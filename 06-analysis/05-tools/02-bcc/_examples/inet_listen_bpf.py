from bcc import BPF

# Hello BPF Program
bpf_text = """ 
#include <net/inet_sock.h>
#include <bcc/proto.h>

// inet_listen kprobe
//
// Test: nc -l 0 1234
//
// int kprobe__inet_listen(struct pt_regs *ctx, struct socket *sock, int backlog)
// {
//    bpf_trace_printk("trjl> Detected inet_listen event.\\n");
//    return 0;
// };


// inet_listen kprobe
//
// Test: nc -l 0 1234
//
// int kprobe__inet_listen(struct pt_regs *ctx, struct socket *sock, int backlog)
// {
//    struct sock *sk = sock->sk;
//     struct inet_sock *inet = inet_sk(sk);
//
//     u16 sport = 0;
//     bpf_probe_read(&sport, sizeof(sport), &(inet->inet_sport));
//
//     bpf_trace_printk("trjl> Listening on port %d with up to %d pending connections!\\n", sport, backlog);
//     return 0;
// };

// inet_listen kprobe
//
// Test: nc -l 0 1234
//
int kprobe__inet_listen(struct pt_regs *ctx, struct socket *sock, int backlog)
{
    struct sock *sk = sock->sk;
    struct inet_sock *inet = inet_sk(sk);    
    bpf_trace_printk("trjl> Listening on port %d with up to %d pending connections!\\n", inet->inet_sport, backlog);
    return 0;
};

"""

# 2. Build and Inject program
b = BPF(text=bpf_text)

# 3. Print debug output
while True:
    print(b.trace_readline())
