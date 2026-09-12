
hfa_param_interleave.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	popq	%rax
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rdi
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	movl	$0x41180000, %edi       # imm = 0x41180000
               	movss	(%rax,%riz), %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	(%rsi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rsi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movq	%rdi, %xmm15
               	addss	%xmm15, %xmm0
               	movl	$0xa, %edx
               	xorps	%xmm2, %xmm2
               	cvtsi2ss	%rdx, %xmm2
               	addss	%xmm2, %xmm0
               	movl	$0x425e0000, %eax       # imm = 0x425E0000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	$0x0, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3e800000, %esi       # imm = 0x3E800000
               	movss	(%rcx,%riz), %xmm0
               	movss	0x4(%rcx,%riz), %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	addss	%xmm15, %xmm1
               	movss	(%rax,%riz), %xmm0
               	movapd	%xmm1, %xmm3
               	addss	%xmm0, %xmm3
               	movss	0x4(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm3
               	addss	%xmm0, %xmm3
               	addss	%xmm1, %xmm3
               	movapd	%xmm0, %xmm15
               	movapd	%xmm3, %xmm0
               	addss	%xmm15, %xmm0
               	addss	%xmm1, %xmm0
               	movq	%rsi, %xmm15
               	addss	%xmm15, %xmm0
               	addss	%xmm2, %xmm0
               	movl	$0x41240000, %eax       # imm = 0x41240000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
