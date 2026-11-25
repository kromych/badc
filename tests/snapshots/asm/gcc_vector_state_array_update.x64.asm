
gcc_vector_state_array_update.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
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
               	vpextrb	$0x0, %xmm0, %ecx
               	shrq	$0x7, %rcx
               	vpextrb	$0x1, %xmm0, %edx
               	shrq	$0x7, %rdx
               	vpextrb	$0x2, %xmm0, %esi
               	shrq	$0x7, %rsi
               	vpextrb	$0x3, %xmm0, %edi
               	shrq	$0x7, %rdi
               	vpextrb	$0x4, %xmm0, %r8d
               	shrq	$0x7, %r8
               	vpextrb	$0x5, %xmm0, %r9d
               	shrq	$0x7, %r9
               	vpextrb	$0x6, %xmm0, %r10d
               	shrq	$0x7, %r10
               	vpextrb	$0x7, %xmm0, %r11d
               	shrq	$0x7, %r11
               	vpextrb	$0x8, %xmm0, %ebx
               	shrq	$0x7, %rbx
               	vpextrb	$0x9, %xmm0, %r12d
               	shrq	$0x7, %r12
               	vpextrb	$0xa, %xmm0, %r13d
               	shrq	$0x7, %r13
               	vpextrb	$0xb, %xmm0, %r14d
               	shrq	$0x7, %r14
               	vpextrb	$0xc, %xmm0, %r15d
               	shrq	$0x7, %r15
               	vpextrb	$0xd, %xmm0, %ebp
               	shrq	$0x7, %rbp
               	movq	%r10, 0x40(%rsp)
               	vpextrb	$0xe, %xmm0, %r10d
               	movq	%r10, 0x58(%rsp)
               	shrq	$0x7, %r10
               	movq	%r10, 0x58(%rsp)
               	vpextrb	$0xf, %xmm0, %r10d
               	movq	%r10, 0x50(%rsp)
               	shrq	$0x7, %r10
               	movq	%r10, 0x50(%rsp)
               	movl	$0x1b, %eax
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	movq	%r11, 0x38(%rsp)
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
               	movq	0x40(%rsp), %r10
               	andq	$0xff, %r9
               	imulq	%rax, %r9
               	vpinsrb	$0x5, %r9d, %xmm0, %xmm0
               	movq	0x38(%rsp), %r11
               	andq	$0xff, %r10
               	imulq	%rax, %r10
               	vpinsrb	$0x6, %r10d, %xmm0, %xmm0
               	andq	$0xff, %r11
               	imulq	%rax, %r11
               	vpinsrb	$0x7, %r11d, %xmm0, %xmm0
               	andq	$0xff, %rbx
               	imulq	%rax, %rbx
               	vpinsrb	$0x8, %ebx, %xmm0, %xmm0
               	andq	$0xff, %r12
               	imulq	%rax, %r12
               	vpinsrb	$0x9, %r12d, %xmm0, %xmm0
               	andq	$0xff, %r13
               	imulq	%rax, %r13
               	vpinsrb	$0xa, %r13d, %xmm0, %xmm0
               	andq	$0xff, %r14
               	imulq	%rax, %r14
               	vpinsrb	$0xb, %r14d, %xmm0, %xmm0
               	andq	$0xff, %r15
               	imulq	%rax, %r15
               	vpinsrb	$0xc, %r15d, %xmm0, %xmm0
               	andq	$0xff, %rbp
               	imulq	%rax, %rbp
               	vpinsrb	$0xd, %ebp, %xmm0, %xmm0
               	andq	$0xff, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r10, %r11
               	vpinsrb	$0xe, %r11d, %xmm0, %xmm0
               	andq	$0xff, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r10, %r11
               	vpinsrb	$0xf, %r11d, %xmm0, %xmm0
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
               	xorq	%rax, %rcx
               	movapd	%xmm1, %xmm0
               	vpinsrb	$0xf, %ecx, %xmm0, %xmm0
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x38, %rsp
               	retq

<save_state>:
               	subq	$0x58, %rsp
               	movq	0x60(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movups	(%rsp), %xmm0
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
               	movups	0x10(%rsp), %xmm0
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
               	movups	0x20(%rsp), %xmm0
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
               	movups	0x30(%rsp), %xmm0
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
               	movups	0x40(%rsp), %xmm0
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
               	addq	$0x58, %rsp
               	retq

<update>:
               	subq	$0x78, %rsp
               	movq	%rdi, 0x60(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0xb8(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movups	%xmm0, 0x50(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x50(%rsp), %xmm14
               	vpxor	%xmm0, %xmm14, %xmm14
               	movups	%xmm14, 0x50(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x40(%rsp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x30(%rsp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x20(%rsp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x10(%rsp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, 0x10(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rsp), %xmm0
               	movups	0x50(%rsp), %xmm15
               	vpxor	%xmm15, %xmm0, %xmm0
               	movups	%xmm0, (%rsp)
               	movq	0x60(%rsp), %rax
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
               	addq	$0x78, %rsp
               	retq

<update_scalar>:
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movzbq	(%rsi), %r9
               	movzbq	0x40(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %r9
               	movzbq	0x1(%rsi), %r10
               	movzbq	0x41(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %r10
               	movzbq	0x2(%rsi), %r11
               	movzbq	0x42(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %r11
               	movzbq	0x3(%rsi), %rbx
               	movzbq	0x43(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %rbx
               	movzbq	0x4(%rsi), %r12
               	movzbq	0x44(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %r12
               	movzbq	0x5(%rsi), %r13
               	movzbq	0x45(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %r13
               	movzbq	0x6(%rsi), %r14
               	movzbq	0x46(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %r14
               	movzbq	0x7(%rsi), %r15
               	movzbq	0x47(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %r15
               	movzbq	0x8(%rsi), %rbp
               	movzbq	0x48(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	xorq	%rax, %rbp
               	movzbq	0x9(%rsi), %r8
               	movq	%r8, 0x68(%rsp)
               	movzbq	0x49(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	0x68(%rsp), %r8
               	xorq	%rax, %r8
               	movq	%r8, 0x68(%rsp)
               	movzbq	0xa(%rsi), %r8
               	movq	%r8, 0x60(%rsp)
               	movzbq	0x4a(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	0x60(%rsp), %r8
               	xorq	%rax, %r8
               	movq	%r8, 0x60(%rsp)
               	movzbq	0xb(%rsi), %r8
               	movq	%r8, 0x58(%rsp)
               	movzbq	0x4b(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	0x58(%rsp), %r8
               	xorq	%rax, %r8
               	movq	%r8, 0x58(%rsp)
               	movzbq	0xc(%rsi), %r8
               	movq	%r8, 0x50(%rsp)
               	movzbq	0x4c(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	0x50(%rsp), %r8
               	xorq	%rax, %r8
               	movq	%r8, 0x50(%rsp)
               	movzbq	0xd(%rsi), %r8
               	movq	%r8, 0x48(%rsp)
               	movzbq	0x4d(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	0x48(%rsp), %r8
               	xorq	%rax, %r8
               	movq	%r8, 0x48(%rsp)
               	movzbq	0xe(%rsi), %r8
               	movq	%r8, 0x40(%rsp)
               	movzbq	0x4e(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	0x40(%rsp), %r8
               	xorq	%rax, %r8
               	movq	%r8, 0x40(%rsp)
               	movzbq	0xf(%rsi), %r8
               	movq	%r8, 0x38(%rsp)
               	movzbq	0x4f(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%rcx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	0x38(%rsp), %r8
               	xorq	%rax, %r8
               	movq	%r8, 0x38(%rsp)
               	movl	$0x4, %eax
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	movzbq	(%rdi,%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	movzbq	(%rdi,%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, (%rdi,%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x1(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x1(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x2(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x2(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x3(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x3(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x4(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x4(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x5(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x5(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x6(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x6(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x7(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x7(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x8(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x8(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0x9(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0x9(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0xa(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0xa(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0xb(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0xb(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0xc(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0xc(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0xd(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0xd(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0xe(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0xe(%rsi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movzbq	0xf(%rsi), %r8
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%rdx, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	xorq	%rcx, %r8
               	movb	%r8b, 0xf(%rsi)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	xorb	%r9b, (%rdi)
               	xorb	%r10b, 0x1(%rdi)
               	xorb	%r11b, 0x2(%rdi)
               	xorb	%bl, 0x3(%rdi)
               	xorb	%r12b, 0x4(%rdi)
               	xorb	%r13b, 0x5(%rdi)
               	xorb	%r14b, 0x6(%rdi)
               	xorb	%r15b, 0x7(%rdi)
               	xorb	%bpl, 0x8(%rdi)
               	movzbq	0x9(%rdi), %rax
               	xorq	0x68(%rsp), %rax
               	movb	%al, 0x9(%rdi)
               	movzbq	0xa(%rdi), %rax
               	xorq	0x60(%rsp), %rax
               	movb	%al, 0xa(%rdi)
               	movzbq	0xb(%rdi), %rax
               	xorq	0x58(%rsp), %rax
               	movb	%al, 0xb(%rdi)
               	movzbq	0xc(%rdi), %rax
               	xorq	0x50(%rsp), %rax
               	movb	%al, 0xc(%rdi)
               	movzbq	0xd(%rdi), %rax
               	xorq	0x48(%rsp), %rax
               	movb	%al, 0xd(%rdi)
               	movzbq	0xe(%rdi), %rax
               	xorq	0x40(%rsp), %rax
               	movb	%al, 0xe(%rdi)
               	movzbq	0xf(%rdi), %rax
               	xorq	0x38(%rsp), %rax
               	movb	%al, 0xf(%rdi)
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq

<run_chunk>:
               	subq	$0xc0, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x50, %rsp
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
               	movups	%xmm0, 0xd0(%rsp)
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
               	movups	%xmm0, 0xe0(%rsp)
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
               	movups	%xmm0, 0xf0(%rsp)
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
               	movups	%xmm0, 0x100(%rsp)
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
               	movups	%xmm1, 0x110(%rsp)
               	movq	0xd0(%rsp), %rax
               	movq	0xd8(%rsp), %rcx
               	movq	0xe0(%rsp), %rdx
               	movq	0xe8(%rsp), %rsi
               	movq	0xf0(%rsp), %rdi
               	movq	0xf8(%rsp), %r8
               	movq	0x100(%rsp), %r9
               	movq	0x108(%rsp), %r10
               	vmovq	%xmm0, %r11
               	vpextrq	$0x1, %xmm1, %r12
               	movq	%rax, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movq	%rdx, 0x90(%rsp)
               	movq	%rsi, 0x98(%rsp)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movq	%r9, 0xb0(%rsp)
               	movq	%r10, 0xb8(%rsp)
               	movq	%r11, 0xc0(%rsp)
               	movq	%r12, 0xc8(%rsp)
               	xorl	%r12d, %r12d
               	cmpl	%r15d, %r12d
               	jge	<addr>
               	leaq	0x80(%rsp), %r13
               	leaq	0xd0(%rsp), %rdi
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
               	leaq	0x120(%rsp), %r9
               	movups	%xmm0, 0x120(%rsp)
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
               	leaq	0xd0(%rsp), %rax
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
               	leaq	0x80(%rsp), %r9
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
               	addq	$0xc0, %rsp
               	retq

<main>:
               	subq	$0x2d8, %rsp            # imm = 0x2D8
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x50, %rsp
               	xorl	%eax, %eax
               	imulq	$0x7, %rax, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x118(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	imulq	$0x1f, %rax, %rcx
               	addq	$0x9, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x258(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x168(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movzbq	0x118(%rsp,%rcx), %rdi
               	movb	%dil, 0x168(%rsp,%rcx)
               	addq	%rcx, %rdx
               	leaq	0x1(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rsi
               	movb	%sil, 0x1(%rdx)
               	leaq	0x168(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	addq	$0x2, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0x2(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdi
               	movb	%dil, 0x3(%rsi)
               	leaq	0x4(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdx
               	movb	%dl, 0x4(%rsi)
               	leaq	0x168(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	addq	$0x5, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0x5(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	leaq	0x6(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdi
               	movb	%dil, 0x6(%rsi)
               	leaq	0x7(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdx
               	movb	%dl, 0x7(%rsi)
               	leaq	0x168(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	addq	$0x8, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0x8(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	leaq	0x9(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdi
               	movb	%dil, 0x9(%rsi)
               	leaq	0xa(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdx
               	movb	%dl, 0xa(%rsi)
               	leaq	0x168(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	addq	$0xb, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0xb(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	leaq	0xc(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdi
               	movb	%dil, 0xc(%rsi)
               	leaq	0xd(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdx
               	movb	%dl, 0xd(%rsi)
               	leaq	0x168(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0xe, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	addq	$0xf, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0xf(%rdx)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	0x168(%rsp), %rdi
               	leaq	0x258(%rsp), %rsi
               	callq	<addr>
               	leaq	0x168(%rsp), %rdi
               	leaq	0x258(%rsp), %rax
               	leaq	0x10(%rax), %rsi
               	callq	<addr>
               	leaq	0x168(%rsp), %rdi
               	leaq	0x258(%rsp), %rax
               	leaq	0x20(%rax), %rsi
               	callq	<addr>
               	leaq	0x168(%rsp), %rdi
               	leaq	0x258(%rsp), %rax
               	leaq	0x30(%rax), %rsi
               	callq	<addr>
               	leaq	0x168(%rsp), %rdi
               	leaq	0x258(%rsp), %rax
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	leaq	0x168(%rsp), %rdi
               	leaq	0x258(%rsp), %rax
               	leaq	0x50(%rax), %rsi
               	callq	<addr>
               	leaq	0x168(%rsp), %rdi
               	leaq	0x258(%rsp), %rax
               	leaq	0x60(%rax), %rsi
               	callq	<addr>
               	leaq	0x168(%rsp), %r12
               	leaq	0x258(%rsp), %rax
               	leaq	0x70(%rax), %rsi
               	movq	%r12, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	0x118(%rsp,%rax), %rdx
               	movb	%dl, 0x1b8(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	0x1b8(%rsp), %rbx
               	leaq	0x258(%rsp), %rsi
               	movl	$0x8, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%r12,%rcx), %rdx
               	leaq	(%rcx,%rax), %rsi
               	movzbq	0x1b8(%rsp,%rsi), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x5, %r8d
               	jl	<addr>
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	movzbq	0x118(%rsp,%rax), %rdx
               	movb	%dl, 0x208(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	0x208(%rsp), %rdi
               	leaq	0x258(%rsp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	0x208(%rsp), %rdi
               	leaq	0x258(%rsp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movl	$0x8, %edx
               	subq	%rbx, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	0x208(%rsp,%rax), %rcx
               	movzbq	0x1b8(%rsp,%rax), %rdx
               	nop
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	movzbq	0x118(%rsp), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x119(%rsp), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x11a(%rsp), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x11b(%rsp), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x11c(%rsp), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x11d(%rsp), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x11e(%rsp), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x11f(%rsp), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x120(%rsp), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x121(%rsp), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0x122(%rsp), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0x123(%rsp), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0x124(%rsp), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0x125(%rsp), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0x126(%rsp), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0x127(%rsp), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movzbq	0x128(%rsp), %rax
               	vpinsrb	$0x0, %eax, %xmm1, %xmm1
               	movzbq	0x129(%rsp), %rax
               	vpinsrb	$0x1, %eax, %xmm1, %xmm1
               	movzbq	0x12a(%rsp), %rax
               	vpinsrb	$0x2, %eax, %xmm1, %xmm1
               	movzbq	0x12b(%rsp), %rax
               	vpinsrb	$0x3, %eax, %xmm1, %xmm1
               	movzbq	0x12c(%rsp), %rax
               	vpinsrb	$0x4, %eax, %xmm1, %xmm1
               	movzbq	0x12d(%rsp), %rax
               	vpinsrb	$0x5, %eax, %xmm1, %xmm1
               	movzbq	0x12e(%rsp), %rax
               	vpinsrb	$0x6, %eax, %xmm1, %xmm1
               	movzbq	0x12f(%rsp), %rax
               	vpinsrb	$0x7, %eax, %xmm1, %xmm1
               	movzbq	0x130(%rsp), %rax
               	vpinsrb	$0x8, %eax, %xmm1, %xmm1
               	movzbq	0x131(%rsp), %rax
               	vpinsrb	$0x9, %eax, %xmm1, %xmm1
               	movzbq	0x132(%rsp), %rax
               	vpinsrb	$0xa, %eax, %xmm1, %xmm1
               	movzbq	0x133(%rsp), %rax
               	vpinsrb	$0xb, %eax, %xmm1, %xmm1
               	movzbq	0x134(%rsp), %rax
               	vpinsrb	$0xc, %eax, %xmm1, %xmm1
               	movzbq	0x135(%rsp), %rax
               	vpinsrb	$0xd, %eax, %xmm1, %xmm1
               	movzbq	0x136(%rsp), %rax
               	vpinsrb	$0xe, %eax, %xmm1, %xmm1
               	movzbq	0x137(%rsp), %rax
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	movzbq	0x138(%rsp), %rax
               	vpinsrb	$0x0, %eax, %xmm2, %xmm2
               	movzbq	0x139(%rsp), %rax
               	vpinsrb	$0x1, %eax, %xmm2, %xmm2
               	movzbq	0x13a(%rsp), %rax
               	vpinsrb	$0x2, %eax, %xmm2, %xmm2
               	movzbq	0x13b(%rsp), %rax
               	vpinsrb	$0x3, %eax, %xmm2, %xmm2
               	movzbq	0x13c(%rsp), %rax
               	vpinsrb	$0x4, %eax, %xmm2, %xmm2
               	movzbq	0x13d(%rsp), %rax
               	vpinsrb	$0x5, %eax, %xmm2, %xmm2
               	movzbq	0x13e(%rsp), %rax
               	vpinsrb	$0x6, %eax, %xmm2, %xmm2
               	movzbq	0x13f(%rsp), %rax
               	vpinsrb	$0x7, %eax, %xmm2, %xmm2
               	movzbq	0x140(%rsp), %rax
               	vpinsrb	$0x8, %eax, %xmm2, %xmm2
               	movzbq	0x141(%rsp), %rax
               	vpinsrb	$0x9, %eax, %xmm2, %xmm2
               	movzbq	0x142(%rsp), %rax
               	vpinsrb	$0xa, %eax, %xmm2, %xmm2
               	movzbq	0x143(%rsp), %rax
               	vpinsrb	$0xb, %eax, %xmm2, %xmm2
               	movzbq	0x144(%rsp), %rax
               	vpinsrb	$0xc, %eax, %xmm2, %xmm2
               	movzbq	0x145(%rsp), %rax
               	vpinsrb	$0xd, %eax, %xmm2, %xmm2
               	movzbq	0x146(%rsp), %rax
               	vpinsrb	$0xe, %eax, %xmm2, %xmm2
               	movzbq	0x147(%rsp), %rax
               	vpinsrb	$0xf, %eax, %xmm2, %xmm2
               	movzbq	0x148(%rsp), %rax
               	vpinsrb	$0x0, %eax, %xmm3, %xmm3
               	movzbq	0x149(%rsp), %rax
               	vpinsrb	$0x1, %eax, %xmm3, %xmm3
               	movzbq	0x14a(%rsp), %rax
               	vpinsrb	$0x2, %eax, %xmm3, %xmm3
               	movzbq	0x14b(%rsp), %rax
               	vpinsrb	$0x3, %eax, %xmm3, %xmm3
               	movzbq	0x14c(%rsp), %rax
               	vpinsrb	$0x4, %eax, %xmm3, %xmm3
               	movzbq	0x14d(%rsp), %rax
               	vpinsrb	$0x5, %eax, %xmm3, %xmm3
               	movzbq	0x14e(%rsp), %rax
               	vpinsrb	$0x6, %eax, %xmm3, %xmm3
               	movzbq	0x14f(%rsp), %rax
               	vpinsrb	$0x7, %eax, %xmm3, %xmm3
               	movzbq	0x150(%rsp), %rax
               	vpinsrb	$0x8, %eax, %xmm3, %xmm3
               	movzbq	0x151(%rsp), %rax
               	vpinsrb	$0x9, %eax, %xmm3, %xmm3
               	movzbq	0x152(%rsp), %rax
               	vpinsrb	$0xa, %eax, %xmm3, %xmm3
               	movzbq	0x153(%rsp), %rax
               	vpinsrb	$0xb, %eax, %xmm3, %xmm3
               	movzbq	0x154(%rsp), %rax
               	vpinsrb	$0xc, %eax, %xmm3, %xmm3
               	movzbq	0x155(%rsp), %rax
               	vpinsrb	$0xd, %eax, %xmm3, %xmm3
               	movzbq	0x156(%rsp), %rax
               	vpinsrb	$0xe, %eax, %xmm3, %xmm3
               	movzbq	0x157(%rsp), %rax
               	vpinsrb	$0xf, %eax, %xmm3, %xmm3
               	movzbq	0x158(%rsp), %rax
               	vpinsrb	$0x0, %eax, %xmm4, %xmm4
               	movzbq	0x159(%rsp), %rax
               	vpinsrb	$0x1, %eax, %xmm4, %xmm4
               	movzbq	0x15a(%rsp), %rax
               	vpinsrb	$0x2, %eax, %xmm4, %xmm4
               	movzbq	0x15b(%rsp), %rax
               	vpinsrb	$0x3, %eax, %xmm4, %xmm4
               	movzbq	0x15c(%rsp), %rax
               	vpinsrb	$0x4, %eax, %xmm4, %xmm4
               	movzbq	0x15d(%rsp), %rax
               	vpinsrb	$0x5, %eax, %xmm4, %xmm4
               	movzbq	0x15e(%rsp), %rax
               	vpinsrb	$0x6, %eax, %xmm4, %xmm4
               	movzbq	0x15f(%rsp), %rax
               	vpinsrb	$0x7, %eax, %xmm4, %xmm4
               	movzbq	0x160(%rsp), %rax
               	vpinsrb	$0x8, %eax, %xmm4, %xmm4
               	movzbq	0x161(%rsp), %rax
               	vpinsrb	$0x9, %eax, %xmm4, %xmm4
               	movzbq	0x162(%rsp), %rax
               	vpinsrb	$0xa, %eax, %xmm4, %xmm4
               	movzbq	0x163(%rsp), %rax
               	vpinsrb	$0xb, %eax, %xmm4, %xmm4
               	movzbq	0x164(%rsp), %rax
               	vpinsrb	$0xc, %eax, %xmm4, %xmm4
               	movzbq	0x165(%rsp), %rax
               	vpinsrb	$0xd, %eax, %xmm4, %xmm4
               	movzbq	0x166(%rsp), %rax
               	vpinsrb	$0xe, %eax, %xmm4, %xmm4
               	movzbq	0x167(%rsp), %rax
               	vpinsrb	$0xf, %eax, %xmm4, %xmm4
               	leaq	0x60(%rsp), %r9
               	movups	%xmm0, 0x60(%rsp)
               	movups	%xmm1, 0x70(%rsp)
               	movups	%xmm2, 0x80(%rsp)
               	movups	%xmm3, 0x90(%rsp)
               	movups	%xmm4, 0xa0(%rsp)
               	leaq	0xb0(%rsp), %rdi
               	movzbq	0x258(%rsp), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x259(%rsp), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x25a(%rsp), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x25b(%rsp), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x25c(%rsp), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x25d(%rsp), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x25e(%rsp), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x25f(%rsp), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x260(%rsp), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x261(%rsp), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0x262(%rsp), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0x263(%rsp), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0x264(%rsp), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0x265(%rsp), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0x266(%rsp), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0x267(%rsp), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	leaq	0x100(%rsp), %rax
               	movups	%xmm0, 0x100(%rsp)
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
               	leaq	0xb0(%rsp), %r9
               	leaq	0x208(%rsp), %rdi
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
               	xorl	%eax, %eax
               	leaq	0x2e0(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movzbq	0x118(%rsp,%rcx), %rdi
               	movb	%dil, 0x2e0(%rsp,%rcx)
               	addq	%rcx, %rdx
               	leaq	0x1(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rsi
               	movb	%sil, 0x1(%rdx)
               	leaq	0x2e0(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	addq	$0x2, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0x2(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdi
               	movb	%dil, 0x3(%rsi)
               	leaq	0x4(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdx
               	movb	%dl, 0x4(%rsi)
               	leaq	0x2e0(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	addq	$0x5, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0x5(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	leaq	0x6(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdi
               	movb	%dil, 0x6(%rsi)
               	leaq	0x7(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdx
               	movb	%dl, 0x7(%rsi)
               	leaq	0x2e0(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	addq	$0x8, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0x8(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	leaq	0x9(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdi
               	movb	%dil, 0x9(%rsi)
               	leaq	0xa(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdx
               	movb	%dl, 0xa(%rsi)
               	leaq	0x2e0(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	addq	$0xb, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0xb(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rsi
               	leaq	0xc(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdi
               	movb	%dil, 0xc(%rsi)
               	leaq	0xd(%rcx), %rdi
               	movzbq	0x118(%rsp,%rdi), %rdx
               	movb	%dl, 0xd(%rsi)
               	leaq	0x2e0(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	addq	$0xe, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	addq	$0xf, %rcx
               	movzbq	0x118(%rsp,%rcx), %rcx
               	movb	%cl, 0xf(%rdx)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	0x2e0(%rsp), %rbx
               	leaq	0x258(%rsp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	leaq	(%rcx,%rax), %rdi
               	movzbq	0x208(%rsp,%rdi), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%r8
               	nopl	(%rax)
               	cmpl	$0x5, %r8d
               	jl	<addr>
               	xorl	%eax, %eax
               	addq	$0x50, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x2d8, %rsp            # imm = 0x2D8
               	retq
               	movl	$0x14, %eax
               	addq	$0x50, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x2d8, %rsp            # imm = 0x2D8
               	retq
               	leaq	0x2(%rbx), %rax
               	addq	$0x50, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x2d8, %rsp            # imm = 0x2D8
               	retq
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x2d8, %rsp            # imm = 0x2D8
               	retq
