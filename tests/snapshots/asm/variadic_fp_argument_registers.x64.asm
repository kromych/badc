
variadic_fp_argument_registers.x64:	file format elf64-x86-64

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
               	movl	$0x40, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movsd	-0xa0(%rbp), %xmm0
               	xorl	%eax, %eax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movsd	<rip>, %xmm1
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
               	movsd	(%rcx), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<vfsum>:
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
               	movss	-0xa0(%rbp), %xmm0
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x40, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	cvtss2sd	%xmm0, %xmm0
               	xorl	%eax, %eax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movsd	<rip>, %xmm1
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
               	movsd	(%rcx), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<mixed>:
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
               	movss	-0xa0(%rbp), %xmm0
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x50, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movsd	(%rax), %xmm1
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movl	(%rax), %eax
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
               	movsd	(%rcx), %xmm2
               	leaq	-0x18(%rbp), %rcx
               	movl	-0xd0(%rbp), %ecx
               	imulq	$0x186a0, %rcx, %rcx    # imm = 0x186A0
               	movslq	%ecx, %rcx
               	xorps	%xmm3, %xmm3
               	cvtsi2ss	%rcx, %xmm3
               	movss	<rip>, %xmm4
               	vfmadd213ss	%xmm3, %xmm4, %xmm0 # xmm0 = (xmm4 * xmm0) + xmm3
               	movsd	-0x90(%rbp), %xmm3
               	movsd	<rip>, %xmm4
               	cvtss2sd	%xmm0, %xmm0
               	vfmadd231sd	%xmm4, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm4) + xmm0
               	movsd	<rip>, %xmm3
               	vfmadd231sd	%xmm3, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm3) + xmm0
               	imulq	$0xa, %rax, %rax
               	movslq	%eax, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	leave
               	retq

<far>:
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
               	movss	-0xa0(%rbp), %xmm0
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	movl	$0x28, (%rax)
               	movl	$0x40, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movsd	(%rax), %xmm1
               	leaq	-0x18(%rbp), %rax
               	movl	-0xd0(%rbp), %eax
               	movl	-0xc8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xc0(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xb8(%rbp), %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	xorps	%xmm2, %xmm2
               	cvtsi2ss	%rax, %xmm2
               	movss	<rip>, %xmm3
               	vfmadd213ss	%xmm2, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm0) + xmm2
               	movl	-0xb0(%rbp), %eax
               	imulq	$0x64, %rax, %rax
               	movslq	%eax, %rax
               	xorps	%xmm2, %xmm2
               	cvtsi2ss	%rax, %xmm2
               	addss	%xmm2, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	addsd	%xmm1, %xmm0
               	leave
               	retq

<far8>:
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
               	movss	-0xa0(%rbp), %xmm0
               	leaq	-0x18(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	movl	$0x30, (%rax)
               	movl	$0x40, 0x4(%rax)
               	leaq	0x28(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movsd	(%rax), %xmm1
               	leaq	-0x18(%rbp), %rax
               	movl	-0xd0(%rbp), %eax
               	movl	-0xc8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xc0(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xb8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xb0(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xa8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x10(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rbp), %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	xorps	%xmm2, %xmm2
               	cvtsi2ss	%rax, %xmm2
               	movss	<rip>, %xmm3
               	vfmadd213ss	%xmm2, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm0) + xmm2
               	movl	0x20(%rbp), %eax
               	imulq	$0x64, %rax, %rax
               	movslq	%eax, %rax
               	xorps	%xmm2, %xmm2
               	cvtsi2ss	%rax, %xmm2
               	addss	%xmm2, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	addsd	%xmm1, %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	<rip>, %xmm0
               	movl	$0x2, %edi
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	movl	$0x1, %edi
               	movsd	<rip>, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	movl	$0x2, %edi
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movss	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movl	$0x5, %esi
               	movsd	<rip>, %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movss	<rip>, %xmm0
               	movl	$0x7, %r8d
               	movsd	<rip>, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movsd	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	subq	$0x20, %rsp
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	movq	$0x9, 0x10(%rsp)
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	movb	$0x2, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
