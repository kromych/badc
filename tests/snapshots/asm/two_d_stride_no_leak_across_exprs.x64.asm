
two_d_stride_no_leak_across_exprs.x64:	file format elf64-x86-64

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
               	subq	$0x500, %rsp            # imm = 0x500
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x500(%rbp), %rdx
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rcx, %xmm0
               	movl	$0x3e800000, %esi       # imm = 0x3E800000
               	movq	%rsi, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rdx,%riz)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x500(%rbp), %rax
               	movss	0x20(%rax,%riz), %xmm0
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x42c60000, %ecx       # imm = 0x42C60000
               	movq	%rcx, %xmm14
               	movss	%xmm14, (%rax,%riz)
               	movss	(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
