
two_d_float_array_partial_init.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdi,%rdx), %r8
               	movss	(%r8), %xmm0
               	leaq	(%rsi,%rdx), %r9
               	movss	(%r9), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %r10d
               	movss	0x4(%r8), %xmm0
               	movss	0x4(%r9), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %r10d
               	leaq	(%rdi,%rdx), %r8
               	movss	0x8(%r8), %xmm0
               	addq	%rsi, %rdx
               	movss	0x8(%rdx), %xmm1
               	nopw	%cs:(%rax,%rax)
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %r9d
               	movss	0xc(%r8), %xmm0
               	movss	0xc(%rdx), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	xorps	%xmm0, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	vaddss	<rip>, %xmm1, %xmm1 # <addr>
               	addss	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %rsi # <addr>
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movq	%r9, %rcx
               	movq	<rip>, %rdx # <addr>
               	movq	(%rdx), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi,%rcx,4), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %rsi # <addr>
               	addq	%rsi, %rdx
               	movss	(%rdx,%rcx,4), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movb	$0x2, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	%r10, %rcx
               	jmp	<addr>
               	movq	%r10, %rcx
               	jmp	<addr>
