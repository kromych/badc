
floating_returns_joined_when_inlined.x64:	file format elf64-x86-64

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

<slow>:
               	movq	0x8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	retq

<sum>:
               	subq	$0x20, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rsi, %r13
               	xorl	%ebx, %ebx
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	addsd	%xmm0, %xmm1
               	incq	%rbx
               	cmpl	%r13d, %ebx
               	jge	<addr>
               	movq	%rbx, %rax
               	shlq	$0x5, %rax
               	leaq	(%r12,%rax), %rdi
               	movl	(%rdi), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsd	0x10(%rdi), %xmm0
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0x8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	jmp	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movsd	%xmm1, 0x28(%rsp)
               	callq	<addr>
               	movsd	0x28(%rsp), %xmm1
               	jmp	<addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	movapd	%xmm1, %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq

<fsum>:
               	xorl	%ecx, %ecx
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x5, %rax
               	leaq	(%rdi,%rax), %rdx
               	movl	(%rdx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movss	0x18(%rdx), %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0x8(%rdx), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	jmp	<addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	$0x7fc00000, %r11d      # imm = 0x7FC00000
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movl	$0x40200000, %r11d      # imm = 0x40200000
               	movq	%r11, %xmm1
               	jmp	<addr>
               	retq

<main>:
               	subq	$0xc8, %rsp
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%rdi)
               	movups	0x40(%rax), %xmm14
               	movups	%xmm14, 0x40(%rdi)
               	movups	0x50(%rax), %xmm14
               	movups	%xmm14, 0x50(%rdi)
               	movups	0x60(%rax), %xmm14
               	movups	%xmm14, 0x60(%rdi)
               	movups	0x70(%rax), %xmm14
               	movups	%xmm14, 0x70(%rdi)
               	movups	0x80(%rax), %xmm14
               	movups	%xmm14, 0x80(%rdi)
               	movups	0x90(%rax), %xmm14
               	movups	%xmm14, 0x90(%rdi)
               	movl	$0x5, %esi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc8, %rsp
               	retq
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rax), %rdi
               	movl	(%rdi), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsd	0x10(%rdi), %xmm0
               	movq	%xmm0, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc8, %rsp
               	retq
               	leaq	0x20(%rsp), %rax
               	leaq	0x80(%rax), %rdi
               	movl	(%rdi), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsd	0x10(%rdi), %xmm0
               	movq	%xmm0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc8, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc8, %rsp
               	retq
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x7fc00000, %r11d      # imm = 0x7FC00000
               	movq	%r11, %xmm0
               	ucomiss	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0xc8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xc8, %rsp
               	retq
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0x8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	jmp	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0x8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	jmp	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
