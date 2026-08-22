
union_fp_member_regs_return.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0xb, %edx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x401e000000000000, %rax # imm = 0x401E000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	leaq	-0x30(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x30(%rbp), %rax
               	movl	$0xb, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x80(%rbp), %rax
               	movsd	(%rax,%riz), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
