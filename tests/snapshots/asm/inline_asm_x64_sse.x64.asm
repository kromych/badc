
inline_asm_x64_sse.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sse_add>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	-0x8(%rbp), %rax
               	movups	%xmm0, -0x60(%rbp,%riz)
               	movups	%xmm1, -0x50(%rbp,%riz)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x28(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movups	-0x60(%rbp,%riz), %xmm0
               	movups	-0x50(%rbp,%riz), %xmm1
               	movslq	-0x8(%rbp), %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq

<sse_mem_add>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x50(%rbp,%riz)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	movd	%ebx, %xmm0
               	paddd	(%rcx), %xmm0
               	movd	%xmm0, %eax
               	movq	-0x28(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movups	-0x50(%rbp,%riz), %xmm0
               	movslq	-0x8(%rbp), %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<sse_movdqu>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0xc(%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movups	%xmm0, -0x60(%rbp,%riz)
               	movq	%rax, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movdqu	(%rbx), %xmm0
               	movdqu	%xmm0, (%rax)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rbx
               	movups	-0x60(%rbp,%riz), %xmm0
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq

<sse_shift>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	movups	%xmm0, -0x40(%rbp,%riz)
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movd	%ebx, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x20(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movups	-0x40(%rbp,%riz), %xmm0
               	movslq	-0x8(%rbp), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<sse_shuffle>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	-0x8(%rbp), %rax
               	movups	%xmm0, -0x60(%rbp,%riz)
               	movups	%xmm1, -0x50(%rbp,%riz)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	movq	-0x28(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movups	-0x60(%rbp,%riz), %xmm0
               	movups	-0x50(%rbp,%riz), %xmm1
               	movslq	-0x8(%rbp), %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq

<movq_roundtrip>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rax
               	movups	%xmm0, -0x40(%rbp,%riz)
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movq	%rbx, %xmm0
               	movq	%xmm0, %rax
               	movq	-0x20(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movups	-0x40(%rbp,%riz), %xmm0
               	movq	-0x8(%rbp), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<sse_float_roundtrip>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x50(%rbp,%riz)
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movdqu	(%rbx), %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	shufps	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	movdqu	%xmm0, (%rax)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movups	-0x50(%rbp,%riz), %xmm0
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<sse_x_constraint>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movups	%xmm7, -0x70(%rbp,%riz)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	-0x58(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x50(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	movdqa	%xmm1, %xmm7
               	paddd	%xmm2, %xmm7
               	movdqa	%xmm7, %xmm0
               	movq	-0x60(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0xa0(%rbp,%riz), %xmm0
               	movups	-0x90(%rbp,%riz), %xmm1
               	movups	-0x80(%rbp,%riz), %xmm2
               	movups	-0x70(%rbp,%riz), %xmm7
               	leaq	-0x38(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq

<cpu_has_avx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%r8, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x18(%rbp), %eax
               	shrq	$0x1c, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<cpu_has_avx2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x7, %edi
               	xorq	%rbx, %rbx
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%rbx, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x10(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<cpu_has_fma>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %edi
               	xorq	%rbx, %rbx
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%rbx, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	shrq	$0xc, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<avx_vpaddd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp,%riz)
               	movups	%xmm1, -0x80(%rbp,%riz)
               	movups	%xmm2, -0x70(%rbp,%riz)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	-0x58(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x50(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	vpaddd	%xmm2, %xmm1, %xmm0
               	movq	-0x60(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x90(%rbp,%riz), %xmm0
               	movups	-0x80(%rbp,%riz), %xmm1
               	movups	-0x70(%rbp,%riz), %xmm2
               	leaq	-0x38(%rbp), %rax
               	movslq	0xc(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<avx_vmem>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x80(%rbp,%riz)
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rbx
               	vmovdqu	(%rbx), %xmm0
               	vmovdqu	%xmm0, (%rax)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
               	movups	-0x80(%rbp,%riz), %xmm0
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	%xmm0, -0x80(%rbp,%riz)
               	movups	%xmm1, -0x70(%rbp,%riz)
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	-0x50(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x48(%rbp), %rax
               	vpaddd	(%rax), %xmm1, %xmm0
               	movq	-0x58(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movq	-0x60(%rbp), %rax
               	movups	-0x80(%rbp,%riz), %xmm0
               	movups	-0x70(%rbp,%riz), %xmm1
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	leaq	-0x38(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<avx_shuf_mul>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	-0x68(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x60(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	vpmulld	%xmm2, %xmm1, %xmm0
               	movq	-0x70(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0xa0(%rbp,%riz), %xmm0
               	movups	-0x90(%rbp,%riz), %xmm1
               	movups	-0x80(%rbp,%riz), %xmm2
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	-0x78(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	vpshufd	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[3,2,1,0]
               	movq	-0x80(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0xa0(%rbp,%riz), %xmm0
               	movups	-0x90(%rbp,%riz), %xmm1
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<fma_vfmadd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x38(%rbp), %rsi
               	movups	%xmm0, -0xe0(%rbp,%riz)
               	movups	%xmm1, -0xd0(%rbp,%riz)
               	movups	%xmm2, -0xc0(%rbp,%riz)
               	movups	%xmm3, -0xb0(%rbp,%riz)
               	movups	%xmm4, -0xa0(%rbp,%riz)
               	movups	%xmm5, -0x90(%rbp,%riz)
               	movups	%xmm6, -0x80(%rbp,%riz)
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	-0x68(%rbp), %r11
               	movups	(%r11,%riz), %xmm4
               	movq	-0x60(%rbp), %r11
               	movups	(%r11,%riz), %xmm5
               	movq	-0x58(%rbp), %r11
               	movups	(%r11,%riz), %xmm6
               	cvtdq2ps	%xmm4, %xmm0
               	cvtdq2ps	%xmm5, %xmm1
               	cvtdq2ps	%xmm6, %xmm2
               	vfmadd231ps	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm0) + xmm2
               	cvtps2dq	%xmm2, %xmm3
               	movq	-0x70(%rbp), %r11
               	movups	%xmm3, (%r11,%riz)
               	movups	-0xe0(%rbp,%riz), %xmm0
               	movups	-0xd0(%rbp,%riz), %xmm1
               	movups	-0xc0(%rbp,%riz), %xmm2
               	movups	-0xb0(%rbp,%riz), %xmm3
               	movups	-0xa0(%rbp,%riz), %xmm4
               	movups	-0x90(%rbp,%riz), %xmm5
               	movups	-0x80(%rbp,%riz), %xmm6
               	leaq	-0x48(%rbp), %rax
               	movslq	0xc(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<avx2_vpbroadcastd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movl	$0x15, %ecx
               	movups	%xmm0, -0x70(%rbp,%riz)
               	movups	%xmm1, -0x60(%rbp,%riz)
               	movups	%xmm2, -0x50(%rbp,%riz)
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	movd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %xmm1
               	vpaddd	%xmm1, %xmm1, %xmm2
               	movq	-0x38(%rbp), %r11
               	movups	%xmm2, (%r11,%riz)
               	movq	-0x40(%rbp), %rax
               	movups	-0x70(%rbp,%riz), %xmm0
               	movups	-0x60(%rbp,%riz), %xmm1
               	movups	-0x50(%rbp,%riz), %xmm2
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<avx2_vpsllvd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp,%riz)
               	movups	%xmm1, -0x80(%rbp,%riz)
               	movups	%xmm2, -0x70(%rbp,%riz)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	-0x58(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x50(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	vpsllvd	%xmm2, %xmm1, %xmm0
               	movq	-0x60(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x90(%rbp,%riz), %xmm0
               	movups	-0x80(%rbp,%riz), %xmm1
               	movups	-0x70(%rbp,%riz), %xmm2
               	leaq	-0x38(%rbp), %rax
               	movslq	0xc(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<avx2_vpblendd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movups	%xmm0, -0x90(%rbp,%riz)
               	movups	%xmm1, -0x80(%rbp,%riz)
               	movups	%xmm2, -0x70(%rbp,%riz)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	-0x58(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x50(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	vpblendd	$0x8, %xmm2, %xmm1, %xmm0 # xmm0 = xmm1[0,1,2],xmm2[3]
               	movq	-0x60(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x90(%rbp,%riz), %xmm0
               	movups	-0x80(%rbp,%riz), %xmm1
               	movups	-0x70(%rbp,%riz), %xmm2
               	leaq	-0x38(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	decq	%rax
               	movslq	%eax, %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x13, %edi
               	movl	$0x17, %esi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x17, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x15, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movl	$0x2a, %esi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
