
gcc_vector_state_array_update.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	vpextrb	$0x0, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x0, %eax, %xmm1, %xmm1
               	vpextrb	$0x1, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x1, %eax, %xmm1, %xmm1
               	vpextrb	$0x2, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x2, %eax, %xmm1, %xmm1
               	vpextrb	$0x3, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x3, %eax, %xmm1, %xmm1
               	vpextrb	$0x4, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x4, %eax, %xmm1, %xmm1
               	vpextrb	$0x5, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x5, %eax, %xmm1, %xmm1
               	vpextrb	$0x6, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x6, %eax, %xmm1, %xmm1
               	vpextrb	$0x7, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x7, %eax, %xmm1, %xmm1
               	vpextrb	$0x8, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x8, %eax, %xmm1, %xmm1
               	vpextrb	$0x9, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x9, %eax, %xmm1, %xmm1
               	vpextrb	$0xa, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xa, %eax, %xmm1, %xmm1
               	vpextrb	$0xb, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xb, %eax, %xmm1, %xmm1
               	vpextrb	$0xc, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xc, %eax, %xmm1, %xmm1
               	vpextrb	$0xd, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xd, %eax, %xmm1, %xmm1
               	vpextrb	$0xe, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xe, %eax, %xmm1, %xmm1
               	vpextrb	$0xf, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	vpextrb	$0x0, %xmm0, %eax
               	movq	%rax, %rcx
               	shrq	$0x7, %rcx
               	vpextrb	$0x1, %xmm0, %eax
               	movq	%rax, %rdx
               	shrq	$0x7, %rdx
               	vpextrb	$0x2, %xmm0, %eax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	vpextrb	$0x3, %xmm0, %eax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	vpextrb	$0x4, %xmm0, %eax
               	movq	%rax, %r8
               	shrq	$0x7, %r8
               	vpextrb	$0x5, %xmm0, %eax
               	movq	%rax, %r9
               	shrq	$0x7, %r9
               	vpextrb	$0x6, %xmm0, %eax
               	movq	%rax, %rbx
               	shrq	$0x7, %rbx
               	vpextrb	$0x7, %xmm0, %eax
               	movq	%rax, %r12
               	shrq	$0x7, %r12
               	vpextrb	$0x8, %xmm0, %eax
               	movq	%rax, %r13
               	shrq	$0x7, %r13
               	vpextrb	$0x9, %xmm0, %eax
               	movq	%rax, %r14
               	shrq	$0x7, %r14
               	vpextrb	$0xa, %xmm0, %eax
               	movq	%rax, %r15
               	shrq	$0x7, %r15
               	vpextrb	$0xb, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x58(%rsp)
               	vpextrb	$0xc, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x50(%rsp)
               	vpextrb	$0xd, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x48(%rsp)
               	vpextrb	$0xe, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x40(%rsp)
               	vpextrb	$0xf, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x1b, %eax
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	andq	$0xff, %rdx
               	imulq	%rax, %rdx
               	vpinsrb	$0x1, %edx, %xmm0, %xmm0
               	andq	$0xff, %rsi
               	imulq	%rax, %rsi
               	vpinsrb	$0x2, %esi, %xmm0, %xmm0
               	andq	$0xff, %rdi
               	imulq	%rax, %rdi
               	vpinsrb	$0x3, %edi, %xmm0, %xmm0
               	andq	$0xff, %r8
               	imulq	%rax, %r8
               	vpinsrb	$0x4, %r8d, %xmm0, %xmm0
               	andq	$0xff, %r9
               	imulq	%rax, %r9
               	vpinsrb	$0x5, %r9d, %xmm0, %xmm0
               	andq	$0xff, %rbx
               	imulq	%rax, %rbx
               	vpinsrb	$0x6, %ebx, %xmm0, %xmm0
               	andq	$0xff, %r12
               	imulq	%rax, %r12
               	vpinsrb	$0x7, %r12d, %xmm0, %xmm0
               	andq	$0xff, %r13
               	imulq	%rax, %r13
               	vpinsrb	$0x8, %r13d, %xmm0, %xmm0
               	andq	$0xff, %r14
               	imulq	%rax, %r14
               	vpinsrb	$0x9, %r14d, %xmm0, %xmm0
               	andq	$0xff, %r15
               	imulq	%rax, %r15
               	vpinsrb	$0xa, %r15d, %xmm0, %xmm0
               	movq	0x58(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movq	0x50(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movq	0x48(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movq	0x40(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movq	0x38(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rcx, %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	vpxor	%xmm0, %xmm1, %xmm0
               	movl	$0x63, %eax
               	vpextrb	$0x0, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x0, %ecx, %xmm1, %xmm1
               	vpextrb	$0x1, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x1, %ecx, %xmm1, %xmm1
               	vpextrb	$0x2, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x2, %ecx, %xmm1, %xmm1
               	vpextrb	$0x3, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x3, %ecx, %xmm1, %xmm1
               	vpextrb	$0x4, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x4, %ecx, %xmm1, %xmm1
               	vpextrb	$0x5, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x5, %ecx, %xmm1, %xmm1
               	vpextrb	$0x6, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x6, %ecx, %xmm1, %xmm1
               	vpextrb	$0x7, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x7, %ecx, %xmm1, %xmm1
               	vpextrb	$0x8, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x8, %ecx, %xmm1, %xmm1
               	vpextrb	$0x9, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x9, %ecx, %xmm1, %xmm1
               	vpextrb	$0xa, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xa, %ecx, %xmm1, %xmm1
               	vpextrb	$0xb, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xb, %ecx, %xmm1, %xmm1
               	vpextrb	$0xc, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xc, %ecx, %xmm1, %xmm1
               	vpextrb	$0xd, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xd, %ecx, %xmm1, %xmm1
               	vpextrb	$0xe, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xe, %ecx, %xmm1, %xmm1
               	vpextrb	$0xf, %xmm0, %ecx
               	xorq	%rcx, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<save_state>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	movb	%al, (%rdi)
               	vpextrb	$0x1, %xmm0, %eax
               	movb	%al, 0x1(%rdi)
               	vpextrb	$0x2, %xmm0, %eax
               	movb	%al, 0x2(%rdi)
               	vpextrb	$0x3, %xmm0, %eax
               	movb	%al, 0x3(%rdi)
               	vpextrb	$0x4, %xmm0, %eax
               	movb	%al, 0x4(%rdi)
               	vpextrb	$0x5, %xmm0, %eax
               	movb	%al, 0x5(%rdi)
               	vpextrb	$0x6, %xmm0, %eax
               	movb	%al, 0x6(%rdi)
               	vpextrb	$0x7, %xmm0, %eax
               	movb	%al, 0x7(%rdi)
               	vpextrb	$0x8, %xmm0, %eax
               	movb	%al, 0x8(%rdi)
               	vpextrb	$0x9, %xmm0, %eax
               	movb	%al, 0x9(%rdi)
               	vpextrb	$0xa, %xmm0, %eax
               	movb	%al, 0xa(%rdi)
               	vpextrb	$0xb, %xmm0, %eax
               	movb	%al, 0xb(%rdi)
               	vpextrb	$0xc, %xmm0, %eax
               	movb	%al, 0xc(%rdi)
               	vpextrb	$0xd, %xmm0, %eax
               	movb	%al, 0xd(%rdi)
               	vpextrb	$0xe, %xmm0, %eax
               	movb	%al, 0xe(%rdi)
               	vpextrb	$0xf, %xmm0, %eax
               	movb	%al, 0xf(%rdi)
               	movups	-0x40(%rbp), %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	movb	%al, 0x10(%rdi)
               	vpextrb	$0x1, %xmm0, %eax
               	movb	%al, 0x11(%rdi)
               	vpextrb	$0x2, %xmm0, %eax
               	movb	%al, 0x12(%rdi)
               	vpextrb	$0x3, %xmm0, %eax
               	movb	%al, 0x13(%rdi)
               	vpextrb	$0x4, %xmm0, %eax
               	movb	%al, 0x14(%rdi)
               	vpextrb	$0x5, %xmm0, %eax
               	movb	%al, 0x15(%rdi)
               	vpextrb	$0x6, %xmm0, %eax
               	movb	%al, 0x16(%rdi)
               	vpextrb	$0x7, %xmm0, %eax
               	movb	%al, 0x17(%rdi)
               	vpextrb	$0x8, %xmm0, %eax
               	movb	%al, 0x18(%rdi)
               	vpextrb	$0x9, %xmm0, %eax
               	movb	%al, 0x19(%rdi)
               	vpextrb	$0xa, %xmm0, %eax
               	movb	%al, 0x1a(%rdi)
               	vpextrb	$0xb, %xmm0, %eax
               	movb	%al, 0x1b(%rdi)
               	vpextrb	$0xc, %xmm0, %eax
               	movb	%al, 0x1c(%rdi)
               	vpextrb	$0xd, %xmm0, %eax
               	movb	%al, 0x1d(%rdi)
               	vpextrb	$0xe, %xmm0, %eax
               	movb	%al, 0x1e(%rdi)
               	vpextrb	$0xf, %xmm0, %eax
               	movb	%al, 0x1f(%rdi)
               	movups	-0x30(%rbp), %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	movb	%al, 0x20(%rdi)
               	vpextrb	$0x1, %xmm0, %eax
               	movb	%al, 0x21(%rdi)
               	vpextrb	$0x2, %xmm0, %eax
               	movb	%al, 0x22(%rdi)
               	vpextrb	$0x3, %xmm0, %eax
               	movb	%al, 0x23(%rdi)
               	vpextrb	$0x4, %xmm0, %eax
               	movb	%al, 0x24(%rdi)
               	vpextrb	$0x5, %xmm0, %eax
               	movb	%al, 0x25(%rdi)
               	vpextrb	$0x6, %xmm0, %eax
               	movb	%al, 0x26(%rdi)
               	vpextrb	$0x7, %xmm0, %eax
               	movb	%al, 0x27(%rdi)
               	vpextrb	$0x8, %xmm0, %eax
               	movb	%al, 0x28(%rdi)
               	vpextrb	$0x9, %xmm0, %eax
               	movb	%al, 0x29(%rdi)
               	vpextrb	$0xa, %xmm0, %eax
               	movb	%al, 0x2a(%rdi)
               	vpextrb	$0xb, %xmm0, %eax
               	movb	%al, 0x2b(%rdi)
               	vpextrb	$0xc, %xmm0, %eax
               	movb	%al, 0x2c(%rdi)
               	vpextrb	$0xd, %xmm0, %eax
               	movb	%al, 0x2d(%rdi)
               	vpextrb	$0xe, %xmm0, %eax
               	movb	%al, 0x2e(%rdi)
               	vpextrb	$0xf, %xmm0, %eax
               	movb	%al, 0x2f(%rdi)
               	movups	-0x20(%rbp), %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	movb	%al, 0x30(%rdi)
               	vpextrb	$0x1, %xmm0, %eax
               	movb	%al, 0x31(%rdi)
               	vpextrb	$0x2, %xmm0, %eax
               	movb	%al, 0x32(%rdi)
               	vpextrb	$0x3, %xmm0, %eax
               	movb	%al, 0x33(%rdi)
               	vpextrb	$0x4, %xmm0, %eax
               	movb	%al, 0x34(%rdi)
               	vpextrb	$0x5, %xmm0, %eax
               	movb	%al, 0x35(%rdi)
               	vpextrb	$0x6, %xmm0, %eax
               	movb	%al, 0x36(%rdi)
               	vpextrb	$0x7, %xmm0, %eax
               	movb	%al, 0x37(%rdi)
               	vpextrb	$0x8, %xmm0, %eax
               	movb	%al, 0x38(%rdi)
               	vpextrb	$0x9, %xmm0, %eax
               	movb	%al, 0x39(%rdi)
               	vpextrb	$0xa, %xmm0, %eax
               	movb	%al, 0x3a(%rdi)
               	vpextrb	$0xb, %xmm0, %eax
               	movb	%al, 0x3b(%rdi)
               	vpextrb	$0xc, %xmm0, %eax
               	movb	%al, 0x3c(%rdi)
               	vpextrb	$0xd, %xmm0, %eax
               	movb	%al, 0x3d(%rdi)
               	vpextrb	$0xe, %xmm0, %eax
               	movb	%al, 0x3e(%rdi)
               	vpextrb	$0xf, %xmm0, %eax
               	movb	%al, 0x3f(%rdi)
               	movups	-0x10(%rbp), %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	movb	%al, 0x40(%rdi)
               	vpextrb	$0x1, %xmm0, %eax
               	movb	%al, 0x41(%rdi)
               	vpextrb	$0x2, %xmm0, %eax
               	movb	%al, 0x42(%rdi)
               	vpextrb	$0x3, %xmm0, %eax
               	movb	%al, 0x43(%rdi)
               	vpextrb	$0x4, %xmm0, %eax
               	movb	%al, 0x44(%rdi)
               	vpextrb	$0x5, %xmm0, %eax
               	movb	%al, 0x45(%rdi)
               	vpextrb	$0x6, %xmm0, %eax
               	movb	%al, 0x46(%rdi)
               	vpextrb	$0x7, %xmm0, %eax
               	movb	%al, 0x47(%rdi)
               	vpextrb	$0x8, %xmm0, %eax
               	movb	%al, 0x48(%rdi)
               	vpextrb	$0x9, %xmm0, %eax
               	movb	%al, 0x49(%rdi)
               	vpextrb	$0xa, %xmm0, %eax
               	movb	%al, 0x4a(%rdi)
               	vpextrb	$0xb, %xmm0, %eax
               	movb	%al, 0x4b(%rdi)
               	vpextrb	$0xc, %xmm0, %eax
               	movb	%al, 0x4c(%rdi)
               	vpextrb	$0xd, %xmm0, %eax
               	movb	%al, 0x4d(%rdi)
               	vpextrb	$0xe, %xmm0, %eax
               	movb	%al, 0x4e(%rdi)
               	vpextrb	$0xf, %xmm0, %eax
               	movb	%al, 0x4f(%rdi)
               	leave
               	retq

<update>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x80(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x78(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movups	%xmm0, 0x50(%rsp)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x50(%rsp), %xmm14
               	vpxor	%xmm0, %xmm14, %xmm14
               	movups	%xmm14, 0x50(%rsp)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	-0x40(%rbp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	-0x50(%rbp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	-0x60(%rbp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	-0x70(%rbp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movups	-0x80(%rbp), %xmm0
               	movups	0x50(%rsp), %xmm15
               	vpxor	%xmm15, %xmm0, %xmm0
               	movups	%xmm0, -0x80(%rbp)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	movups	0x40(%rcx), %xmm14
               	movups	%xmm14, 0x40(%rax)
               	leave
               	retq

<update_scalar>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movzbq	(%rsi), %rcx
               	movzbq	0x40(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r9
               	xorq	%rax, %r9
               	movzbq	0x1(%rsi), %rcx
               	movzbq	0x41(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %rbx
               	xorq	%rax, %rbx
               	movzbq	0x2(%rsi), %rcx
               	movzbq	0x42(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r12
               	xorq	%rax, %r12
               	movzbq	0x3(%rsi), %rcx
               	movzbq	0x43(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r13
               	xorq	%rax, %r13
               	movzbq	0x4(%rsi), %rcx
               	movzbq	0x44(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r14
               	xorq	%rax, %r14
               	movzbq	0x5(%rsi), %rcx
               	movzbq	0x45(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r15
               	xorq	%rax, %r15
               	movzbq	0x6(%rsi), %rcx
               	movzbq	0x46(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movzbq	0x7(%rsi), %rcx
               	movzbq	0x47(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	movzbq	0x8(%rsi), %rcx
               	movzbq	0x48(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0x9(%rsi), %rcx
               	movzbq	0x49(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xa(%rsi), %rcx
               	movzbq	0x4a(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xb(%rsi), %rcx
               	movzbq	0x4b(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xc(%rsi), %rcx
               	movzbq	0x4c(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xd(%rsi), %rcx
               	movzbq	0x4d(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movzbq	0xe(%rsi), %rcx
               	movzbq	0x4e(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	movzbq	0xf(%rsi), %rcx
               	movzbq	0x4f(%rdi), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movzbq	(%rdi,%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, (%rdi,%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x1(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x1(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x1(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x2(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x2(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x2(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x3(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x3(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x3(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x4(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x4(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x4(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x5(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x5(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x5(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x6(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x6(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x6(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x7(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x7(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x7(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x8(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x8(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x9(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x9(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x9(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xa(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xa(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xa(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xb(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xb(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xb(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xc(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xc(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xc(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xd(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xd(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xd(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xe(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xe(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xe(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xf(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xf(%rcx)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	xorb	%r9b, (%rdi)
               	xorb	%bl, 0x1(%rdi)
               	xorb	%r12b, 0x2(%rdi)
               	xorb	%r13b, 0x3(%rdi)
               	xorb	%r14b, 0x4(%rdi)
               	xorb	%r15b, 0x5(%rdi)
               	movzbq	0x6(%rdi), %rax
               	xorq	0x78(%rsp), %rax
               	movb	%al, 0x6(%rdi)
               	movzbq	0x7(%rdi), %rax
               	xorq	0x70(%rsp), %rax
               	movb	%al, 0x7(%rdi)
               	movzbq	0x8(%rdi), %rax
               	xorq	0x68(%rsp), %rax
               	movb	%al, 0x8(%rdi)
               	movzbq	0x9(%rdi), %rax
               	xorq	0x60(%rsp), %rax
               	movb	%al, 0x9(%rdi)
               	movzbq	0xa(%rdi), %rax
               	xorq	0x58(%rsp), %rax
               	movb	%al, 0xa(%rdi)
               	movzbq	0xb(%rdi), %rax
               	xorq	0x50(%rsp), %rax
               	movb	%al, 0xb(%rdi)
               	movzbq	0xc(%rdi), %rax
               	xorq	0x48(%rsp), %rax
               	movb	%al, 0xc(%rdi)
               	movzbq	0xd(%rdi), %rax
               	xorq	0x40(%rsp), %rax
               	movb	%al, 0xd(%rdi)
               	movzbq	0xe(%rdi), %rax
               	xorq	0x38(%rsp), %rax
               	movb	%al, 0xe(%rdi)
               	movzbq	0xf(%rdi), %rax
               	xorq	0x30(%rsp), %rax
               	movb	%al, 0xf(%rdi)
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<run_chunk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r15
               	movq	%rsi, %r14
               	movzbq	(%rbx), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x1(%rbx), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x2(%rbx), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x3(%rbx), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x4(%rbx), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x5(%rbx), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x6(%rbx), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x7(%rbx), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x8(%rbx), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x9(%rbx), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0xa(%rbx), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0xb(%rbx), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0xc(%rbx), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0xd(%rbx), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0xe(%rbx), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0xf(%rbx), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	movzbq	0x10(%rbx), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x11(%rbx), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x12(%rbx), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x13(%rbx), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x14(%rbx), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x15(%rbx), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x16(%rbx), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x17(%rbx), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x18(%rbx), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x19(%rbx), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0x1a(%rbx), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0x1b(%rbx), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0x1c(%rbx), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0x1d(%rbx), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0x1e(%rbx), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0x1f(%rbx), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	movzbq	0x20(%rbx), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x21(%rbx), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x22(%rbx), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x23(%rbx), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x24(%rbx), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x25(%rbx), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x26(%rbx), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x27(%rbx), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x28(%rbx), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x29(%rbx), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0x2a(%rbx), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0x2b(%rbx), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0x2c(%rbx), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0x2d(%rbx), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0x2e(%rbx), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0x2f(%rbx), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	movzbq	0x30(%rbx), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x31(%rbx), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x32(%rbx), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x33(%rbx), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x34(%rbx), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x35(%rbx), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x36(%rbx), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x37(%rbx), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x38(%rbx), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x39(%rbx), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0x3a(%rbx), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0x3b(%rbx), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0x3c(%rbx), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0x3d(%rbx), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0x3e(%rbx), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0x3f(%rbx), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	movzbq	0x40(%rbx), %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x41(%rbx), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x42(%rbx), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x43(%rbx), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x44(%rbx), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x45(%rbx), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x46(%rbx), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x47(%rbx), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x48(%rbx), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrb	$0x8, %eax, %xmm1, %xmm1
               	movzbq	0x49(%rbx), %rax
               	vpinsrb	$0x9, %eax, %xmm1, %xmm1
               	movzbq	0x4a(%rbx), %rax
               	vpinsrb	$0xa, %eax, %xmm1, %xmm1
               	movzbq	0x4b(%rbx), %rax
               	vpinsrb	$0xb, %eax, %xmm1, %xmm1
               	movzbq	0x4c(%rbx), %rax
               	vpinsrb	$0xc, %eax, %xmm1, %xmm1
               	movzbq	0x4d(%rbx), %rax
               	vpinsrb	$0xd, %eax, %xmm1, %xmm1
               	movzbq	0x4e(%rbx), %rax
               	vpinsrb	$0xe, %eax, %xmm1, %xmm1
               	movzbq	0x4f(%rbx), %rax
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	movups	%xmm1, -0x30(%rbp)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rdx
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdi
               	movq	-0x48(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x38(%rbp), %r12
               	vmovq	%xmm0, %r13
               	vpextrq	$0x1, %xmm1, %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	%rax, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rsi, -0xa8(%rbp)
               	movq	%rdi, -0xa0(%rbp)
               	movq	%r8, -0x98(%rbp)
               	movq	%r9, -0x90(%rbp)
               	movq	%r12, -0x88(%rbp)
               	movq	%r13, -0x80(%rbp)
               	movq	0xe8(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	xorl	%r12d, %r12d
               	cmpl	%r15d, %r12d
               	jge	<addr>
               	leaq	-0xc0(%rbp), %r13
               	leaq	-0x70(%rbp), %rdi
               	movq	%r12, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rcx
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	movzbq	0x1(%rax), %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movzbq	0x2(%rax), %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movzbq	0x3(%rax), %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	movzbq	0x4(%rax), %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	movzbq	0x5(%rax), %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	movzbq	0x6(%rax), %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	movzbq	0x7(%rax), %rcx
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	movzbq	0x8(%rax), %rcx
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	movzbq	0x9(%rax), %rcx
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	movzbq	0xa(%rax), %rcx
               	vpinsrb	$0xa, %ecx, %xmm0, %xmm0
               	movzbq	0xb(%rax), %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movzbq	0xc(%rax), %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movzbq	0xd(%rax), %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movzbq	0xe(%rax), %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r9
               	subq	$0x50, %rsp
               	movq	%r13, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0x70(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r13)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r13)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%r13)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%r13)
               	movups	0x40(%rax), %xmm14
               	movups	%xmm14, 0x40(%r13)
               	incq	%r12
               	cmpl	%r15d, %r12d
               	jl	<addr>
               	leaq	-0xc0(%rbp), %r9
               	subq	$0x50, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	$0x50, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2d0, %rsp            # imm = 0x2D0
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	imulq	$0x7, %rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x218(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	imulq	$0x1f, %rax, %rdx
               	addq	$0x9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0xd8(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x1c8(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rsi
               	movb	%sil, -0x1c8(%rbp,%rcx)
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x1(%rcx), %rdi
               	movzbq	-0x218(%rbp,%rdi), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %r8
               	movzbq	-0x218(%rbp,%r8), %r8
               	movb	%r8b, 0x2(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movzbq	-0x218(%rbp,%rdi), %rdx
               	movb	%dl, 0x3(%rsi)
               	leaq	-0x1c8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x4, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rcx
               	movb	%cl, 0x4(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x5(%rcx), %rdx
               	movzbq	-0x218(%rbp,%rdx), %rdx
               	movb	%dl, 0x5(%rdi)
               	leaq	0x6(%rcx), %rsi
               	movzbq	-0x218(%rbp,%rsi), %rsi
               	movb	%sil, 0x6(%rdi)
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %r8
               	movzbq	-0x218(%rbp,%r8), %r8
               	movb	%r8b, 0x7(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x8(%rcx), %rdi
               	movzbq	-0x218(%rbp,%rdi), %rdx
               	movb	%dl, 0x8(%rsi)
               	leaq	-0x1c8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x9, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rcx
               	movb	%cl, 0x9(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0xa(%rcx), %rdx
               	movzbq	-0x218(%rbp,%rdx), %rdx
               	movb	%dl, 0xa(%rdi)
               	leaq	0xb(%rcx), %rsi
               	movzbq	-0x218(%rbp,%rsi), %rsi
               	movb	%sil, 0xb(%rdi)
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xc(%rcx), %r8
               	movzbq	-0x218(%rbp,%r8), %r8
               	movb	%r8b, 0xc(%rdi)
               	addq	%rcx, %rsi
               	leaq	0xd(%rcx), %rdi
               	movzbq	-0x218(%rbp,%rdi), %rdx
               	movb	%dl, 0xd(%rsi)
               	leaq	-0x1c8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0xe, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	addq	$0xf, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rcx
               	movb	%cl, 0xf(%rdx)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x50(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %r12
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x70(%rax), %rsi
               	movq	%r12, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x218(%rbp,%rax), %rdx
               	movb	%dl, -0x178(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x178(%rbp), %rbx
               	leaq	-0xd8(%rbp), %rsi
               	movl	$0x8, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%r12,%rcx), %rdx
               	leaq	(%rcx,%rax), %rsi
               	movzbq	-0x178(%rbp,%rsi), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x5, %r8d
               	jl	<addr>
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	movzbq	-0x218(%rbp,%rax), %rdx
               	movb	%dl, -0x128(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x128(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x128(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movl	$0x8, %edx
               	subq	%rbx, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x128(%rbp,%rax), %rcx
               	movzbq	-0x178(%rbp,%rax), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	movzbq	-0x218(%rbp), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	-0x217(%rbp), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	-0x216(%rbp), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	-0x215(%rbp), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	-0x214(%rbp), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	-0x213(%rbp), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	-0x212(%rbp), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	-0x211(%rbp), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	-0x210(%rbp), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	-0x20f(%rbp), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	-0x20e(%rbp), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	-0x20d(%rbp), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	-0x20c(%rbp), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	-0x20b(%rbp), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	-0x20a(%rbp), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	-0x209(%rbp), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movzbq	-0x208(%rbp), %rax
               	vpinsrb	$0x0, %eax, %xmm1, %xmm1
               	movzbq	-0x207(%rbp), %rax
               	vpinsrb	$0x1, %eax, %xmm1, %xmm1
               	movzbq	-0x206(%rbp), %rax
               	vpinsrb	$0x2, %eax, %xmm1, %xmm1
               	movzbq	-0x205(%rbp), %rax
               	vpinsrb	$0x3, %eax, %xmm1, %xmm1
               	movzbq	-0x204(%rbp), %rax
               	vpinsrb	$0x4, %eax, %xmm1, %xmm1
               	movzbq	-0x203(%rbp), %rax
               	vpinsrb	$0x5, %eax, %xmm1, %xmm1
               	movzbq	-0x202(%rbp), %rax
               	vpinsrb	$0x6, %eax, %xmm1, %xmm1
               	movzbq	-0x201(%rbp), %rax
               	vpinsrb	$0x7, %eax, %xmm1, %xmm1
               	movzbq	-0x200(%rbp), %rax
               	vpinsrb	$0x8, %eax, %xmm1, %xmm1
               	movzbq	-0x1ff(%rbp), %rax
               	vpinsrb	$0x9, %eax, %xmm1, %xmm1
               	movzbq	-0x1fe(%rbp), %rax
               	vpinsrb	$0xa, %eax, %xmm1, %xmm1
               	movzbq	-0x1fd(%rbp), %rax
               	vpinsrb	$0xb, %eax, %xmm1, %xmm1
               	movzbq	-0x1fc(%rbp), %rax
               	vpinsrb	$0xc, %eax, %xmm1, %xmm1
               	movzbq	-0x1fb(%rbp), %rax
               	vpinsrb	$0xd, %eax, %xmm1, %xmm1
               	movzbq	-0x1fa(%rbp), %rax
               	vpinsrb	$0xe, %eax, %xmm1, %xmm1
               	movzbq	-0x1f9(%rbp), %rax
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	movzbq	-0x1f8(%rbp), %rax
               	vpinsrb	$0x0, %eax, %xmm2, %xmm2
               	movzbq	-0x1f7(%rbp), %rax
               	vpinsrb	$0x1, %eax, %xmm2, %xmm2
               	movzbq	-0x1f6(%rbp), %rax
               	vpinsrb	$0x2, %eax, %xmm2, %xmm2
               	movzbq	-0x1f5(%rbp), %rax
               	vpinsrb	$0x3, %eax, %xmm2, %xmm2
               	movzbq	-0x1f4(%rbp), %rax
               	vpinsrb	$0x4, %eax, %xmm2, %xmm2
               	movzbq	-0x1f3(%rbp), %rax
               	vpinsrb	$0x5, %eax, %xmm2, %xmm2
               	movzbq	-0x1f2(%rbp), %rax
               	vpinsrb	$0x6, %eax, %xmm2, %xmm2
               	movzbq	-0x1f1(%rbp), %rax
               	vpinsrb	$0x7, %eax, %xmm2, %xmm2
               	movzbq	-0x1f0(%rbp), %rax
               	vpinsrb	$0x8, %eax, %xmm2, %xmm2
               	movzbq	-0x1ef(%rbp), %rax
               	vpinsrb	$0x9, %eax, %xmm2, %xmm2
               	movzbq	-0x1ee(%rbp), %rax
               	vpinsrb	$0xa, %eax, %xmm2, %xmm2
               	movzbq	-0x1ed(%rbp), %rax
               	vpinsrb	$0xb, %eax, %xmm2, %xmm2
               	movzbq	-0x1ec(%rbp), %rax
               	vpinsrb	$0xc, %eax, %xmm2, %xmm2
               	movzbq	-0x1eb(%rbp), %rax
               	vpinsrb	$0xd, %eax, %xmm2, %xmm2
               	movzbq	-0x1ea(%rbp), %rax
               	vpinsrb	$0xe, %eax, %xmm2, %xmm2
               	movzbq	-0x1e9(%rbp), %rax
               	vpinsrb	$0xf, %eax, %xmm2, %xmm2
               	movzbq	-0x1e8(%rbp), %rax
               	vpinsrb	$0x0, %eax, %xmm3, %xmm3
               	movzbq	-0x1e7(%rbp), %rax
               	vpinsrb	$0x1, %eax, %xmm3, %xmm3
               	movzbq	-0x1e6(%rbp), %rax
               	vpinsrb	$0x2, %eax, %xmm3, %xmm3
               	movzbq	-0x1e5(%rbp), %rax
               	vpinsrb	$0x3, %eax, %xmm3, %xmm3
               	movzbq	-0x1e4(%rbp), %rax
               	vpinsrb	$0x4, %eax, %xmm3, %xmm3
               	movzbq	-0x1e3(%rbp), %rax
               	vpinsrb	$0x5, %eax, %xmm3, %xmm3
               	movzbq	-0x1e2(%rbp), %rax
               	vpinsrb	$0x6, %eax, %xmm3, %xmm3
               	movzbq	-0x1e1(%rbp), %rax
               	vpinsrb	$0x7, %eax, %xmm3, %xmm3
               	movzbq	-0x1e0(%rbp), %rax
               	vpinsrb	$0x8, %eax, %xmm3, %xmm3
               	movzbq	-0x1df(%rbp), %rax
               	vpinsrb	$0x9, %eax, %xmm3, %xmm3
               	movzbq	-0x1de(%rbp), %rax
               	vpinsrb	$0xa, %eax, %xmm3, %xmm3
               	movzbq	-0x1dd(%rbp), %rax
               	vpinsrb	$0xb, %eax, %xmm3, %xmm3
               	movzbq	-0x1dc(%rbp), %rax
               	vpinsrb	$0xc, %eax, %xmm3, %xmm3
               	movzbq	-0x1db(%rbp), %rax
               	vpinsrb	$0xd, %eax, %xmm3, %xmm3
               	movzbq	-0x1da(%rbp), %rax
               	vpinsrb	$0xe, %eax, %xmm3, %xmm3
               	movzbq	-0x1d9(%rbp), %rax
               	vpinsrb	$0xf, %eax, %xmm3, %xmm3
               	movzbq	-0x1d8(%rbp), %rax
               	vpinsrb	$0x0, %eax, %xmm4, %xmm4
               	movzbq	-0x1d7(%rbp), %rax
               	vpinsrb	$0x1, %eax, %xmm4, %xmm4
               	movzbq	-0x1d6(%rbp), %rax
               	vpinsrb	$0x2, %eax, %xmm4, %xmm4
               	movzbq	-0x1d5(%rbp), %rax
               	vpinsrb	$0x3, %eax, %xmm4, %xmm4
               	movzbq	-0x1d4(%rbp), %rax
               	vpinsrb	$0x4, %eax, %xmm4, %xmm4
               	movzbq	-0x1d3(%rbp), %rax
               	vpinsrb	$0x5, %eax, %xmm4, %xmm4
               	movzbq	-0x1d2(%rbp), %rax
               	vpinsrb	$0x6, %eax, %xmm4, %xmm4
               	movzbq	-0x1d1(%rbp), %rax
               	vpinsrb	$0x7, %eax, %xmm4, %xmm4
               	movzbq	-0x1d0(%rbp), %rax
               	vpinsrb	$0x8, %eax, %xmm4, %xmm4
               	movzbq	-0x1cf(%rbp), %rax
               	vpinsrb	$0x9, %eax, %xmm4, %xmm4
               	movzbq	-0x1ce(%rbp), %rax
               	vpinsrb	$0xa, %eax, %xmm4, %xmm4
               	movzbq	-0x1cd(%rbp), %rax
               	vpinsrb	$0xb, %eax, %xmm4, %xmm4
               	movzbq	-0x1cc(%rbp), %rax
               	vpinsrb	$0xc, %eax, %xmm4, %xmm4
               	movzbq	-0x1cb(%rbp), %rax
               	vpinsrb	$0xd, %eax, %xmm4, %xmm4
               	movzbq	-0x1ca(%rbp), %rax
               	vpinsrb	$0xe, %eax, %xmm4, %xmm4
               	movzbq	-0x1c9(%rbp), %rax
               	vpinsrb	$0xf, %eax, %xmm4, %xmm4
               	leaq	-0x2d0(%rbp), %r9
               	movups	%xmm0, -0x2d0(%rbp)
               	movups	%xmm1, -0x2c0(%rbp)
               	movups	%xmm2, -0x2b0(%rbp)
               	movups	%xmm3, -0x2a0(%rbp)
               	movups	%xmm4, -0x290(%rbp)
               	leaq	-0x280(%rbp), %rdi
               	movzbq	-0xd8(%rbp), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	-0xd7(%rbp), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	-0xd6(%rbp), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	-0xd5(%rbp), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	-0xd4(%rbp), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	-0xd3(%rbp), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	-0xd2(%rbp), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	-0xd1(%rbp), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	-0xd0(%rbp), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	-0xcf(%rbp), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	-0xce(%rbp), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	-0xcd(%rbp), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	-0xcc(%rbp), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	-0xcb(%rbp), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	-0xca(%rbp), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	-0xc9(%rbp), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	leaq	-0x230(%rbp), %rax
               	movups	%xmm0, -0x230(%rbp)
               	subq	$0x50, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0x280(%rbp), %r9
               	leaq	-0x128(%rbp), %rdi
               	subq	$0x50, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	callq	<addr>
               	addq	$0x50, %rsp
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rsi
               	movb	%sil, -0x50(%rbp,%rcx)
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x1(%rcx), %rdi
               	movzbq	-0x218(%rbp,%rdi), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %r8
               	movzbq	-0x218(%rbp,%r8), %r8
               	movb	%r8b, 0x2(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movzbq	-0x218(%rbp,%rdi), %rdx
               	movb	%dl, 0x3(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x4, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rcx
               	movb	%cl, 0x4(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x5(%rcx), %rdx
               	movzbq	-0x218(%rbp,%rdx), %rdx
               	movb	%dl, 0x5(%rdi)
               	leaq	0x6(%rcx), %rsi
               	movzbq	-0x218(%rbp,%rsi), %rsi
               	movb	%sil, 0x6(%rdi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %r8
               	movzbq	-0x218(%rbp,%r8), %r8
               	movb	%r8b, 0x7(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x8(%rcx), %rdi
               	movzbq	-0x218(%rbp,%rdi), %rdx
               	movb	%dl, 0x8(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0x9, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rcx
               	movb	%cl, 0x9(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0xa(%rcx), %rdx
               	movzbq	-0x218(%rbp,%rdx), %rdx
               	movb	%dl, 0xa(%rdi)
               	leaq	0xb(%rcx), %rsi
               	movzbq	-0x218(%rbp,%rsi), %rsi
               	movb	%sil, 0xb(%rdi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xc(%rcx), %r8
               	movzbq	-0x218(%rbp,%r8), %r8
               	movb	%r8b, 0xc(%rdi)
               	addq	%rcx, %rsi
               	leaq	0xd(%rcx), %rdi
               	movzbq	-0x218(%rbp,%rdi), %rdx
               	movb	%dl, 0xd(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0xe, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	addq	$0xf, %rcx
               	movzbq	-0x218(%rbp,%rcx), %rcx
               	movb	%cl, 0xf(%rdx)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rbx
               	leaq	-0xd8(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	leaq	(%rcx,%rax), %rdi
               	movzbq	-0x128(%rbp,%rdi), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x5, %r8d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x2(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
