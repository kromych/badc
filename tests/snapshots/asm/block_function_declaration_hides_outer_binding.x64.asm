
block_function_declaration_hides_outer_binding.x64:	file format elf64-x86-64

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

<hides_local>:
               	movl	$0x70, %eax
               	retq

<hides_parameter>:
               	movl	$0x8, %eax
               	retq

<hides_static>:
               	movl	$0x3c, %eax
               	retq

<hides_block_local>:
               	movl	$0x46, %eax
               	retq

<hides_enumerator>:
               	movl	$0x10, %eax
               	retq

<hides_typedef>:
               	movl	$0x5a, %eax
               	retq

<hides_library>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	$-0x5, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<composite_prototype>:
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	$0x64, %rax
               	retq

<hides_with_variadic>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x4002000000000000, %rcx # imm = 0x4002000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rdx, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	movl	$0x7, %eax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	popq	%rbp
               	retq

<declared_in_an_outer_block>:
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	$0x3, %rax
               	retq

<outer_block_double>:
               	movl	$0x1, %eax
               	leaq	<rip>, %rcx # <addr>
               	movslq	(%rcx), %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	retq

<outer_block_pointer>:
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	subq	$0x4, %rax
               	movslq	%eax, %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	retq

<add100>:
               	leaq	0x64(%rdi), %rax
               	retq

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<later>:
               	imulq	$0xa, %rdi, %rax
               	retq

<unproto>:
               	imulq	$0x64, %rdi, %rax
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	retq

<big>:
               	movslq	%edi, %rdi
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	retq

<half>:
               	movslq	%edi, %rdi
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdi, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	retq

<at>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax # <addr>
               	addq	%rdi, %rax
               	retq

<vsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movsd	(%rcx), %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	callq	<addr>
               	cmpl	$0x70, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x3c, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x46, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x10, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x5a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x6, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x78, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x7, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	movabsq	$0x402d800000000000, %rax # imm = 0x402D800000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	shlq	$0x8, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpq	$0x138b, %rax           # imm = 0x138B
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x9, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	shlq	$0xa, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	incq	%rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0xb, %rax
               	orq	%rbx, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq
