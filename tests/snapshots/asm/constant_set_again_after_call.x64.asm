
constant_set_again_after_call.x64:	file format elf64-x86-64

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

<note>:
               	movq	<rip>, %rax # <addr>
               	addq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	leaq	0x1(%rdi), %rax
               	retq

<scale>:
               	movq	<rip>, %rax # <addr>
               	cvttsd2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movsd	<rip>, %xmm1
               	mulsd	%xmm1, %xmm0
               	retq

<fma_constant>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	%xmm1, 0x10(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	0x18(%rsp), %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movsd	<rip>, %xmm1
               	vfmadd231sd	0x18(%rsp), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	cvttsd2si	%xmm0, %rax
               	leave
               	retq

<promoted_constant>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x5, %edi
               	callq	<addr>
               	addq	%r12, %rax
               	movl	$0x5, %ecx
               	imulq	%rbx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<phi_income>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x3, %rax
               	cmovleq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq

<returned_constant>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq

<wide_constant>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	movabsq	$0x123456789ab, %r11    # imm = 0x123456789AB
               	xorq	%r11, %rax
               	movabsq	$0x123456789a, %r11     # imm = 0x123456789A
               	addq	%r11, %rax
               	popq	%rbp
               	retq

<f32_constant>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cvtss2sd	%xmm0, %xmm0
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm1
               	movss	<rip>, %xmm0
               	vfmadd213ss	%xmm0, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm0
               	popq	%rbp
               	retq

<address_constant>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rsi
               	addq	%rsi, %rdx
               	addq	%rbx, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x8, %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<function_address>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	incq	%rax
               	popq	%rbp
               	retq

<in_loop>:
               	testq	%rdi, %rdi
               	jle	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x3, %rax
               	addq	%rax, %r12
               	incq	%rbx
               	cmpq	%r13, %rbx
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	retq

<two_runs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	addq	$0x9, %rdi
               	callq	<addr>
               	leaq	0x9(%rax), %rdi
               	callq	<addr>
               	leaq	0x9(%rax), %rdi
               	callq	<addr>
               	addq	$0x9, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x1f, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movabsq	$0x13579be0242, %r11    # imm = 0x13579BE0242
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x77, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
