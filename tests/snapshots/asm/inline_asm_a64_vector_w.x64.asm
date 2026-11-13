
inline_asm_a64_vector_w.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movw	$0x1403, -0x30(%rbp)    # imm = 0x1403
               	movw	$0xeff0, -0x20(%rbp)    # imm = 0xEFF0
               	movw	$0x3625, -0x2e(%rbp)    # imm = 0x3625
               	movw	$0xedee, -0x1e(%rbp)    # imm = 0xEDEE
               	movw	$0x5847, -0x2c(%rbp)    # imm = 0x5847
               	movw	$0xebec, -0x1c(%rbp)    # imm = 0xEBEC
               	movw	$0x7a69, -0x2a(%rbp)    # imm = 0x7A69
               	movw	$0xe9ea, -0x1a(%rbp)    # imm = 0xE9EA
               	movw	$0x9c8b, -0x28(%rbp)    # imm = 0x9C8B
               	movw	$0xe7e8, -0x18(%rbp)    # imm = 0xE7E8
               	movw	$0xbead, -0x26(%rbp)    # imm = 0xBEAD
               	movw	$0xe5e6, -0x16(%rbp)    # imm = 0xE5E6
               	movw	$0xe0cf, -0x24(%rbp)    # imm = 0xE0CF
               	movw	$0xe3e4, -0x14(%rbp)    # imm = 0xE3E4
               	movw	$0x2f1, -0x22(%rbp)     # imm = 0x2F1
               	movw	$0xe1e2, -0x12(%rbp)    # imm = 0xE1E2
               	movzbq	-0x30(%rbp), %rax
               	movzbq	-0x20(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x10(%rbp)
               	movzbq	-0x2f(%rbp), %rax
               	movzbq	-0x1f(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xf(%rbp)
               	movzbq	-0x2e(%rbp), %rax
               	movzbq	-0x1e(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xe(%rbp)
               	movzbq	-0x2d(%rbp), %rax
               	movzbq	-0x1d(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xd(%rbp)
               	movzbq	-0x2c(%rbp), %rax
               	movzbq	-0x1c(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xc(%rbp)
               	movzbq	-0x2b(%rbp), %rax
               	movzbq	-0x1b(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xb(%rbp)
               	movzbq	-0x2a(%rbp), %rax
               	movzbq	-0x1a(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xa(%rbp)
               	movzbq	-0x29(%rbp), %rax
               	movzbq	-0x19(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x9(%rbp)
               	movzbq	-0x28(%rbp), %rax
               	movzbq	-0x18(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x27(%rbp), %rax
               	movzbq	-0x17(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x7(%rbp)
               	movzbq	-0x26(%rbp), %rax
               	movzbq	-0x16(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x6(%rbp)
               	movzbq	-0x25(%rbp), %rax
               	movzbq	-0x15(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x5(%rbp)
               	movzbq	-0x24(%rbp), %rax
               	movzbq	-0x14(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x4(%rbp)
               	movzbq	-0x23(%rbp), %rax
               	movzbq	-0x13(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x3(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movzbq	-0x22(%rbp), %rax
               	leaq	-0x20(%rbp), %rdx
               	movzbq	-0x12(%rbp), %rsi
               	xorq	%rsi, %rax
               	movb	%al, -0x2(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movzbq	-0x21(%rbp), %rax
               	movzbq	-0x11(%rbp), %rdi
               	xorq	%rdi, %rax
               	movb	%al, -0x1(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdi
               	movzbq	(%rcx,%rax), %r8
               	movzbq	(%rdx,%rax), %r9
               	xorq	%r9, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
