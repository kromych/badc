
two_d_float_array_partial_init.x64:	file format elf64-x86-64

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
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	%rdx, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %rsi
               	movss	(%rsi), %xmm0
               	leaq	<rip>, %rdi # <addr>
               	addq	%rax, %rdi
               	movss	(%rdi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %r8d
               	movss	0x4(%rsi), %xmm0
               	leaq	<rip>, %rsi # <addr>
               	addq	%rax, %rsi
               	movss	0x4(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %r8d
               	leaq	<rip>, %rdi # <addr>
               	addq	%rax, %rdi
               	movss	0x8(%rdi), %xmm0
               	movss	0x8(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	<rip>, %rsi # <addr>
               	addq	%rax, %rsi
               	movss	0xc(%rsi), %xmm0
               	leaq	<rip>, %rsi # <addr>
               	addq	%rsi, %rax
               	movss	0xc(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0xc, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movq	%rax, %xmm14
               	vaddss	%xmm0, %xmm14, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	movss	<rip>, %xmm2 # <addr>
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movq	%rdi, %rcx
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rdx, %rax
               	shlq	$0x4, %rax
               	leaq	(%r8,%rax), %r9
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	movss	(%r9), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %r9 # <addr>
               	addq	%r9, %rax
               	addq	%r8, %rax
               	movss	(%rax), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%r8, %rcx
               	jmp	<addr>
               	movq	%r8, %rcx
               	jmp	<addr>
