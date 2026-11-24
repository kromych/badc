
inline_asm_a64_vector_w.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x38, %rsp
               	movw	$0x1403, (%rsp)         # imm = 0x1403
               	movw	$0xeff0, 0x10(%rsp)     # imm = 0xEFF0
               	movw	$0x3625, 0x2(%rsp)      # imm = 0x3625
               	movw	$0xedee, 0x12(%rsp)     # imm = 0xEDEE
               	movw	$0x5847, 0x4(%rsp)      # imm = 0x5847
               	movw	$0xebec, 0x14(%rsp)     # imm = 0xEBEC
               	movw	$0x7a69, 0x6(%rsp)      # imm = 0x7A69
               	movw	$0xe9ea, 0x16(%rsp)     # imm = 0xE9EA
               	movw	$0x9c8b, 0x8(%rsp)      # imm = 0x9C8B
               	movw	$0xe7e8, 0x18(%rsp)     # imm = 0xE7E8
               	movw	$0xbead, 0xa(%rsp)      # imm = 0xBEAD
               	movw	$0xe5e6, 0x1a(%rsp)     # imm = 0xE5E6
               	movw	$0xe0cf, 0xc(%rsp)      # imm = 0xE0CF
               	movw	$0xe3e4, 0x1c(%rsp)     # imm = 0xE3E4
               	movw	$0x2f1, 0xe(%rsp)       # imm = 0x2F1
               	movw	$0xe1e2, 0x1e(%rsp)     # imm = 0xE1E2
               	movzbq	(%rsp), %rax
               	movzbq	0x10(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x20(%rsp)
               	movzbq	0x1(%rsp), %rax
               	movzbq	0x11(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x21(%rsp)
               	movzbq	0x2(%rsp), %rax
               	movzbq	0x12(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x22(%rsp)
               	movzbq	0x3(%rsp), %rax
               	movzbq	0x13(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x23(%rsp)
               	movzbq	0x4(%rsp), %rax
               	movzbq	0x14(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x24(%rsp)
               	movzbq	0x5(%rsp), %rax
               	movzbq	0x15(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x25(%rsp)
               	movzbq	0x6(%rsp), %rax
               	movzbq	0x16(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x26(%rsp)
               	movzbq	0x7(%rsp), %rax
               	movzbq	0x17(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x27(%rsp)
               	movzbq	0x8(%rsp), %rax
               	movzbq	0x18(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x28(%rsp)
               	movzbq	0x9(%rsp), %rax
               	movzbq	0x19(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x29(%rsp)
               	movzbq	0xa(%rsp), %rax
               	movzbq	0x1a(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x2a(%rsp)
               	movzbq	0xb(%rsp), %rax
               	movzbq	0x1b(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x2b(%rsp)
               	movzbq	0xc(%rsp), %rax
               	movzbq	0x1c(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x2c(%rsp)
               	movzbq	0xd(%rsp), %rax
               	movzbq	0x1d(%rsp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, 0x2d(%rsp)
               	movzbq	0xe(%rsp), %rax
               	movzbq	0x1e(%rsp), %rsi
               	xorq	%rsi, %rax
               	movb	%al, 0x2e(%rsp)
               	movzbq	0xf(%rsp), %rax
               	movzbq	0x1f(%rsp), %rdi
               	xorq	%rdi, %rax
               	movb	%al, 0x2f(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdi
               	movzbq	(%rsp,%rax), %r8
               	movzbq	0x10(%rsp,%rax), %r9
               	xorq	%r9, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
