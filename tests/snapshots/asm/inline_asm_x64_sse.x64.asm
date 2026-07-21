
inline_asm_x64_sse.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2e0, %rsp            # imm = 0x2E0
               	movq	%rbx, (%rsp)
               	movl	$0x13, %eax
               	movl	$0x17, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movq	%rax, -0x2b0(%rbp)
               	movq	%rcx, -0x2a8(%rbp)
               	movq	%rbx, -0x2a0(%rbp)
               	movq	%rdx, -0x298(%rbp)
               	movq	%rax, -0x290(%rbp)
               	movq	%rcx, -0x288(%rbp)
               	movq	-0x290(%rbp), %rbx
               	movq	-0x288(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x298(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x2b0(%rbp), %rax
               	movq	-0x2a8(%rbp), %rcx
               	movq	-0x2a0(%rbp), %rbx
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x17, %eax
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movq	%rax, -0x2c0(%rbp)
               	movq	%rcx, -0x2b8(%rbp)
               	movq	%rbx, -0x2b0(%rbp)
               	movq	%rcx, -0x2a8(%rbp)
               	movq	%rax, -0x2a0(%rbp)
               	movq	%rdx, -0x298(%rbp)
               	movq	-0x2a0(%rbp), %rbx
               	movq	-0x298(%rbp), %rcx
               	movd	%ebx, %xmm0
               	paddd	(%rcx), %xmm0
               	movd	%xmm0, %eax
               	movq	-0x2a8(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x2c0(%rbp), %rax
               	movq	-0x2b8(%rbp), %rcx
               	movq	-0x2b0(%rbp), %rbx
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x38(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movq	%rax, -0x2c0(%rbp)
               	movq	%rbx, -0x2b8(%rbp)
               	movq	%rax, -0x2b0(%rbp)
               	movq	%rcx, -0x2a8(%rbp)
               	movq	-0x2b0(%rbp), %rax
               	movq	-0x2a8(%rbp), %rbx
               	movdqu	(%rbx), %xmm0
               	movdqu	%xmm0, (%rax)
               	movq	-0x2c0(%rbp), %rax
               	movq	-0x2b8(%rbp), %rbx
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x15, %eax
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movq	%rax, -0x2c0(%rbp)
               	movq	%rbx, -0x2b8(%rbp)
               	movq	%rcx, -0x2b0(%rbp)
               	movq	%rax, -0x2a8(%rbp)
               	movq	-0x2a8(%rbp), %rbx
               	movd	%ebx, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x2b0(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x2c0(%rbp), %rax
               	movq	-0x2b8(%rbp), %rbx
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movslq	-0x50(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	$0x2a, %ecx
               	leaq	-0x58(%rbp), %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movq	%rax, -0x2b0(%rbp)
               	movq	%rcx, -0x2a8(%rbp)
               	movq	%rbx, -0x2a0(%rbp)
               	movq	%rdx, -0x298(%rbp)
               	movq	%rax, -0x290(%rbp)
               	movq	%rcx, -0x288(%rbp)
               	movq	-0x290(%rbp), %rbx
               	movq	-0x288(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	movq	-0x298(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x2b0(%rbp), %rax
               	movq	-0x2a8(%rbp), %rcx
               	movq	-0x2a0(%rbp), %rbx
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movslq	-0x58(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x60(%rbp), %rcx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movq	%rax, -0x2c0(%rbp)
               	movq	%rbx, -0x2b8(%rbp)
               	movq	%rcx, -0x2b0(%rbp)
               	movq	%rax, -0x2a8(%rbp)
               	movq	-0x2a8(%rbp), %rbx
               	movq	%rbx, %xmm0
               	movq	%xmm0, %rax
               	movq	-0x2b0(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x2c0(%rbp), %rax
               	movq	-0x2b8(%rbp), %rbx
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movq	-0x60(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movq	%rax, -0x2c0(%rbp)
               	movq	%rbx, -0x2b8(%rbp)
               	movq	%rax, -0x2b0(%rbp)
               	movq	%rcx, -0x2a8(%rbp)
               	movq	-0x2b0(%rbp), %rax
               	movq	-0x2a8(%rbp), %rbx
               	movdqu	(%rbx), %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	shufps	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	movdqu	%xmm0, (%rax)
               	movq	-0x2c0(%rbp), %rax
               	movq	-0x2b8(%rbp), %rbx
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0xa0(%rbp), %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movups	%xmm2, -0x2b0(%rbp,%riz)
               	movups	%xmm7, -0x2a0(%rbp,%riz)
               	movq	%rax, -0x290(%rbp)
               	movq	%rcx, -0x288(%rbp)
               	movq	%rdx, -0x280(%rbp)
               	movq	-0x288(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x280(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	movdqa	%xmm1, %xmm7
               	paddd	%xmm2, %xmm7
               	movdqa	%xmm7, %xmm0
               	movq	-0x290(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movups	-0x2b0(%rbp,%riz), %xmm2
               	movups	-0x2a0(%rbp,%riz), %xmm7
               	leaq	-0xb0(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xc8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xd8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe8(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	leaq	-0xd8(%rbp), %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movups	%xmm2, -0x2b0(%rbp,%riz)
               	movq	%rax, -0x2a0(%rbp)
               	movq	%rcx, -0x298(%rbp)
               	movq	%rdx, -0x290(%rbp)
               	movq	-0x298(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x290(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	vpaddd	%xmm2, %xmm1, %xmm0
               	movq	-0x2a0(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movups	-0x2b0(%rbp,%riz), %xmm2
               	leaq	-0xe8(%rbp), %rax
               	movslq	0xc(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x100(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movq	%rax, -0x2c0(%rbp)
               	movq	%rbx, -0x2b8(%rbp)
               	movq	%rax, -0x2b0(%rbp)
               	movq	%rcx, -0x2a8(%rbp)
               	movq	-0x2b0(%rbp), %rax
               	movq	-0x2a8(%rbp), %rbx
               	vmovdqu	(%rbx), %xmm0
               	vmovdqu	%xmm0, (%rax)
               	movq	-0x2c0(%rbp), %rax
               	movq	-0x2b8(%rbp), %rbx
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	leaq	-0x110(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x120(%rbp), %rax
               	leaq	-0x110(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movq	%rax, -0x2b0(%rbp)
               	movq	%rax, -0x2a8(%rbp)
               	movq	%rcx, -0x2a0(%rbp)
               	movq	%rdx, -0x298(%rbp)
               	movq	-0x2a0(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x298(%rbp), %rax
               	vpaddd	(%rax), %xmm1, %xmm0
               	movq	-0x2a8(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movq	-0x2b0(%rbp), %rax
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	leaq	-0x100(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x100(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	leaq	-0x120(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x138(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x148(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x138(%rbp), %rcx
               	leaq	-0x148(%rbp), %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movups	%xmm2, -0x2b0(%rbp,%riz)
               	movq	%rax, -0x2a0(%rbp)
               	movq	%rcx, -0x298(%rbp)
               	movq	%rdx, -0x290(%rbp)
               	movq	-0x298(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x290(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	vpmulld	%xmm2, %xmm1, %xmm0
               	movq	-0x2a0(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movups	-0x2b0(%rbp,%riz), %xmm2
               	leaq	-0x168(%rbp), %rax
               	leaq	-0x158(%rbp), %rcx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movq	%rax, -0x2b0(%rbp)
               	movq	%rcx, -0x2a8(%rbp)
               	movq	-0x2a8(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	vpshufd	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[3,2,1,0]
               	movq	-0x2b0(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	leaq	-0x168(%rbp), %rax
               	movslq	(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x180(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x190(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1a0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1b0(%rbp), %rax
               	leaq	-0x180(%rbp), %rcx
               	leaq	-0x190(%rbp), %rdx
               	leaq	-0x1a0(%rbp), %rsi
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movups	%xmm2, -0x2b0(%rbp,%riz)
               	movups	%xmm3, -0x2a0(%rbp,%riz)
               	movups	%xmm4, -0x290(%rbp,%riz)
               	movups	%xmm5, -0x280(%rbp,%riz)
               	movups	%xmm6, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	%rdx, -0x250(%rbp)
               	movq	%rsi, -0x248(%rbp)
               	movq	-0x258(%rbp), %r11
               	movups	(%r11,%riz), %xmm4
               	movq	-0x250(%rbp), %r11
               	movups	(%r11,%riz), %xmm5
               	movq	-0x248(%rbp), %r11
               	movups	(%r11,%riz), %xmm6
               	cvtdq2ps	%xmm4, %xmm0
               	cvtdq2ps	%xmm5, %xmm1
               	cvtdq2ps	%xmm6, %xmm2
               	vfmadd231ps	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm0) + xmm2
               	cvtps2dq	%xmm2, %xmm3
               	movq	-0x260(%rbp), %r11
               	movups	%xmm3, (%r11,%riz)
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movups	-0x2b0(%rbp,%riz), %xmm2
               	movups	-0x2a0(%rbp,%riz), %xmm3
               	movups	-0x290(%rbp,%riz), %xmm4
               	movups	-0x280(%rbp,%riz), %xmm5
               	movups	-0x270(%rbp,%riz), %xmm6
               	leaq	-0x1b0(%rbp), %rax
               	movslq	0xc(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x1c8(%rbp), %rax
               	movl	$0x15, %ecx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movups	%xmm2, -0x2b0(%rbp,%riz)
               	movq	%rax, -0x2a0(%rbp)
               	movq	%rax, -0x298(%rbp)
               	movq	%rcx, -0x290(%rbp)
               	movq	-0x290(%rbp), %rax
               	movd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %xmm1
               	vpaddd	%xmm1, %xmm1, %xmm2
               	movq	-0x298(%rbp), %r11
               	movups	%xmm2, (%r11,%riz)
               	movq	-0x2a0(%rbp), %rax
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movups	-0x2b0(%rbp,%riz), %xmm2
               	leaq	-0x1c8(%rbp), %rax
               	movslq	0x8(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x1e0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1f0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x200(%rbp), %rax
               	leaq	-0x1e0(%rbp), %rcx
               	leaq	-0x1f0(%rbp), %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movups	%xmm2, -0x2b0(%rbp,%riz)
               	movq	%rax, -0x2a0(%rbp)
               	movq	%rcx, -0x298(%rbp)
               	movq	%rdx, -0x290(%rbp)
               	movq	-0x298(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x290(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	vpsllvd	%xmm2, %xmm1, %xmm0
               	movq	-0x2a0(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movups	-0x2b0(%rbp,%riz), %xmm2
               	leaq	-0x200(%rbp), %rax
               	movslq	0xc(%rax), %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x218(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x228(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x238(%rbp), %rax
               	leaq	-0x218(%rbp), %rcx
               	leaq	-0x228(%rbp), %rdx
               	movups	%xmm0, -0x2d0(%rbp,%riz)
               	movups	%xmm1, -0x2c0(%rbp,%riz)
               	movups	%xmm2, -0x2b0(%rbp,%riz)
               	movq	%rax, -0x2a0(%rbp)
               	movq	%rcx, -0x298(%rbp)
               	movq	%rdx, -0x290(%rbp)
               	movq	-0x298(%rbp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	-0x290(%rbp), %r11
               	movups	(%r11,%riz), %xmm2
               	vpblendd	$0x8, %xmm2, %xmm1, %xmm0 # xmm0 = xmm1[0,1,2],xmm2[3]
               	movq	-0x2a0(%rbp), %r11
               	movups	%xmm0, (%r11,%riz)
               	movups	-0x2d0(%rbp,%riz), %xmm0
               	movups	-0x2c0(%rbp,%riz), %xmm1
               	movups	-0x2b0(%rbp,%riz), %xmm2
               	leaq	-0x238(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	leaq	-0x238(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	decq	%rax
               	movslq	%eax, %rbx
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2e0, %rsp            # imm = 0x2E0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
