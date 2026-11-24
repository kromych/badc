
long_double_call_shapes.x64:	file format elf64-x86-64

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

<ret_ld>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	leaq	0x10(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x28, %rsp
               	retq

<ret_int>:
               	subq	$0x18, %rsp
               	movabsq	$0x401c000000000000, %rcx # imm = 0x401C000000000000
               	leaq	(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x18, %rsp
               	retq

<ret_float>:
               	subq	$0x18, %rsp
               	cvtss2sd	%xmm0, %xmm0
               	leaq	(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x18, %rsp
               	retq

<mk1>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	0x10(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x28, %rsp
               	retq

<mk2>:
               	subq	$0x58, %rsp
               	movq	%rdi, 0x40(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	addq	$0x58, %rsp
               	retq

<mkn>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	0x10(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x28, %rsp
               	retq

<mku>:
               	subq	$0x38, %rsp
               	movq	%rdi, 0x20(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x48(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	0x10(%rsp), %rcx
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movq	0x20(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x38, %rsp
               	retq

<take1>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	leaq	0x10(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x28, %rsp
               	retq

<take2>:
               	subq	$0x38, %rsp
               	movq	0x40(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x48(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	leaq	0x20(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x38, %rsp
               	retq

<many>:
               	subq	$0x48, %rsp
               	movq	0x50(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x58(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	vaddsd	<rip>, %xmm1, %xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	fldt	0x20(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	leaq	0x30(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x48, %rsp
               	retq

<past>:
               	subq	$0x38, %rsp
               	movq	0x50(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x58(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	addsd	%xmm3, %xmm0
               	addsd	%xmm4, %xmm0
               	addsd	%xmm5, %xmm0
               	addsd	%xmm6, %xmm0
               	addsd	%xmm7, %xmm0
               	movsd	0x40(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	vaddsd	%xmm1, %xmm0, %xmm1
               	vaddsd	<rip>, %xmm1, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	movslq	0x60(%rsp), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	leaq	0x20(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x38, %rsp
               	retq

<vsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
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
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xf0(%rbp)
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	fldt	-0xf0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rcx
               	fldt	(%rcx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xf0(%rbp)
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	fldt	-0xf0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0xe0(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xe0(%rbp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<vmix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
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
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0xf8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x100(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x20(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	fldt	-0x100(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xf0(%rbp)
               	xorl	%eax, %eax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	fldt	-0xf0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xf0(%rbp)
               	fldt	-0xf0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rcx
               	fldt	(%rcx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xf0(%rbp)
               	fldt	-0xf0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
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
               	vaddsd	(%rcx), %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xf0(%rbp)
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	nop
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	fldt	-0xf0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0xe0(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xe0(%rbp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<first>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
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
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rax
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xf0(%rbp)
               	leaq	-0x18(%rbp), %rax
               	fldt	-0xf0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movslq	-0xd0(%rbp), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	leaq	-0xe0(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0xe0(%rbp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	leave
               	retq

<rec>:
               	subq	$0x48, %rsp
               	subq	$0x10, %rsp
               	movq	0x60(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	testl	%edi, %edi
               	je	<addr>
               	decq	%rdi
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	leaq	0x20(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0x40(%rsp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x40(%rsp)
               	movq	%rax, %rcx
               	fldt	(%rcx)
               	addq	$0x10, %rsp
               	addq	$0x48, %rsp
               	retq
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	jmp	<addr>

<halve>:
               	vdivsd	<rip>, %xmm0, %xmm0
               	retq

<main>:
               	subq	$0x148, %rsp            # imm = 0x148
               	subq	$0x90, %rsp
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x90(%rsp)
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	leaq	0xa0(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	leaq	0xe0(%rsp), %rdi
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	leaq	0xc0(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	leaq	0xe0(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0xb0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	leaq	0xc0(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	leaq	0xc0(%rsp), %rdi
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	leaq	0xe0(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fldt	0xc0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	leaq	0xc0(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	leaq	0xa0(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movsd	<rip>, %xmm0
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movl	$0x5, %esi
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	leaq	0x100(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x100(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xa0(%rsp), %rcx
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movl	$0x1, %edi
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	movsd	<rip>, %xmm4
               	movsd	<rip>, %xmm5
               	movsd	<rip>, %xmm6
               	movsd	<rip>, %xmm7
               	movsd	<rip>, %xmm8
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%xmm8, %r10
               	movq	%r10, (%rsp)
               	movq	%rdi, 0x20(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movl	$0x3, %edi
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	leaq	0x100(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x100(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xa0(%rsp), %rcx
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movl	$0x2, %edi
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movl	$0x1, %esi
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movsd	<rip>, %xmm0
               	movl	$0x4, %edx
               	movabsq	$0x4014000000000000, %r8 # imm = 0x4014000000000000
               	movsd	<rip>, %xmm1
               	leaq	0x100(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x100(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xa0(%rsp), %rcx
               	movq	%r8, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movb	$0x2, %al
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	<rip>, %rcx # <addr>
               	leaq	0xa0(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	*%rcx
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	<rip>, %rcx # <addr>
               	leaq	0xa0(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	*%rcx
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movl	$0x9, %edi
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	<rip>, %rdx # <addr>
               	leaq	0x110(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x110(%rsp)
               	leaq	0x120(%rsp), %rsi
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x120(%rsp)
               	leaq	0x130(%rsp), %r8
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x130(%rsp)
               	leaq	0x140(%rsp), %r10
               	movq	%r10, 0x198(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x140(%rsp)
               	leaq	0x150(%rsp), %r10
               	movq	%r10, 0x190(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x150(%rsp)
               	leaq	0x160(%rsp), %r10
               	movq	%r10, 0x188(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x160(%rsp)
               	leaq	0x100(%rsp), %r10
               	movq	%r10, 0x180(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x100(%rsp)
               	leaq	0xc0(%rsp), %r10
               	movq	%r10, 0x178(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rsi, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r8, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x198(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x190(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x188(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	0x180(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	0x178(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x80(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x88(%rsp)
               	movb	$0x0, %al
               	callq	*%rdx
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movl	$0x1, 0x1a0(%rsp)
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	mulsd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xd0(%rsp)
               	fldt	0xd0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	leaq	0xc0(%rsp), %rax
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	0xc0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	mulsd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rcx
               	movq	0xe8(%rsp), %rdx
               	movq	%rcx, 0xa0(%rsp)
               	movq	%rdx, 0xa8(%rsp)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xd0(%rsp)
               	fldt	0xd0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	0xc0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	mulsd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rcx
               	movq	0xe8(%rsp), %rdx
               	movq	%rcx, 0xa0(%rsp)
               	movq	%rdx, 0xa8(%rsp)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xd0(%rsp)
               	fldt	0xd0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	0xc0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	mulsd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xd0(%rsp)
               	fldt	0xd0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movabsq	$0x4008000000000000, %rsi # imm = 0x4008000000000000
               	leaq	0xc0(%rsp), %rax
               	movq	%rsi, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	0xc0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	mulsd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xd0(%rsp)
               	fldt	0xd0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movslq	0x1a0(%rsp), %rcx
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	leaq	0xe0(%rsp), %rdx
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	leaq	0xc0(%rsp), %rdi
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xa0(%rsp), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0xe0(%rsp), %rdx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rdx)
               	testq	%rcx, %rcx
               	je	<addr>
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rdx
               	movq	0xe8(%rsp), %rcx
               	movq	%rdx, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0x1a0(%rsp), %ecx
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	leaq	0xc0(%rsp), %rsi
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xc0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xe0(%rsp), %rdx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	testl	%ecx, %ecx
               	jne	<addr>
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rdx
               	movq	0xe8(%rsp), %rcx
               	movq	%rdx, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movl	$0x2, %edi
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movl	$0x3, %edi
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	mulsd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	fldt	0xa0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x1a8(%rsp)
               	movl	$0x3f000000, 0x1b0(%rsp) # imm = 0x3F000000
               	movsd	0x1a8(%rsp), %xmm0
               	movq	<rip>, %rax # <addr>
               	leaq	0xa0(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	*%rax
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x1b0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	<rip>, %rax # <addr>
               	leaq	0xa0(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	*%rax
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	<rip>, %rcx # <addr>
               	leaq	0xa0(%rsp), %r9
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	*%rcx
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	movsd	0x1a8(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r9
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xa0(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	fstpt	0xe0(%rsp)
               	fldt	0xe0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	0x90(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	xorl	%eax, %eax
               	addq	$0x90, %rsp
               	addq	$0x148, %rsp            # imm = 0x148
               	retq
               	fldt	0xc0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rdx
               	movq	0xe8(%rsp), %rcx
               	jmp	<addr>
               	fldt	0xc0(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0xe0(%rsp)
               	movq	0xe0(%rsp), %rdx
               	movq	0xe8(%rsp), %rcx
               	jmp	<addr>
