
fp_compare_with_constants.x64:	file format elf64-x86-64

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

<double_lt>:
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	retq

<double_le>:
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	retq

<double_gt>:
               	comisd	<rip>, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	retq

<double_ge>:
               	comisd	<rip>, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	retq

<double_eq>:
               	ucomisd	<rip>, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	retq

<double_ne>:
               	ucomisd	<rip>, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	retq

<double_klt>:
               	comisd	<rip>, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	retq

<double_kle>:
               	comisd	<rip>, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	retq

<double_kgt>:
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	retq

<double_kge>:
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	retq

<double_blt>:
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_ble>:
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_bgt>:
               	comisd	<rip>, %xmm0
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_bge>:
               	comisd	<rip>, %xmm0
               	jb	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_beq>:
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_bne>:
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_bklt>:
               	comisd	<rip>, %xmm0
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_bkle>:
               	comisd	<rip>, %xmm0
               	jb	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_bkgt>:
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<double_bkge>:
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_lt>:
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	retq

<float_le>:
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	retq

<float_gt>:
               	comiss	<rip>, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	retq

<float_ge>:
               	comiss	<rip>, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	retq

<float_eq>:
               	ucomiss	<rip>, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	retq

<float_ne>:
               	ucomiss	<rip>, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	retq

<float_klt>:
               	comiss	<rip>, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	retq

<float_kle>:
               	comiss	<rip>, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	retq

<float_kgt>:
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	retq

<float_kge>:
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%al
               	movzbq	%al, %rax
               	retq

<float_blt>:
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_ble>:
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_bgt>:
               	comiss	<rip>, %xmm0
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_bge>:
               	comiss	<rip>, %xmm0
               	jb	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_beq>:
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_bne>:
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_bklt>:
               	comiss	<rip>, %xmm0
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_bkle>:
               	comiss	<rip>, %xmm0
               	jb	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_bkgt>:
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<float_bkge>:
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<escapes>:
               	movapd	%xmm0, %xmm4
               	xorl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	xorps	%xmm2, %xmm2
               	vmulsd	%xmm0, %xmm0, %xmm3
               	vfmsub231sd	%xmm2, %xmm2, %xmm3 # xmm3 = (xmm2 * xmm2) - xmm3
               	addsd	%xmm4, %xmm3
               	vmulsd	<rip>, %xmm2, %xmm2
               	vfmadd213sd	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm1
               	vmulsd	%xmm0, %xmm0, %xmm2
               	vfmadd231sd	%xmm3, %xmm3, %xmm2 # xmm2 = (xmm3 * xmm3) + xmm2
               	comisd	<rip>, %xmm2
               	ja	<addr>
               	incq	%rax
               	movapd	%xmm3, %xmm2
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movq	$-0x1, %rax
               	retq
               	retq

<main>:
               	subq	$0x118, %rsp            # imm = 0x118
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movss	<rip>, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, 0x128(%rsp)
               	leaq	0x38(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x38(%rsp)
               	xorl	%r13d, %r13d
               	movq	$0x1, 0x40(%rsp)
               	movl	%r13d, 0x48(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x50(%rsp)
               	movq	$0x1, 0x58(%rsp)
               	movl	%r13d, 0x60(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x68(%rsp)
               	movq	$0x1, 0x70(%rsp)
               	movl	%r13d, 0x78(%rsp)
               	movq	%r13, %xmm14
               	movsd	%xmm14, 0x80(%rsp)
               	movq	$0x1, 0x88(%rsp)
               	movl	%r13d, 0x90(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x98(%rsp)
               	movq	$0x1, 0xa0(%rsp)
               	movl	%r13d, 0xa8(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xb0(%rsp)
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movq	%rcx, 0xb8(%rsp)
               	movl	%r13d, 0xc0(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xc8(%rsp)
               	movq	$0x0, 0xd0(%rsp)
               	movl	%r13d, 0xd8(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xe0(%rsp)
               	movq	$0x0, 0xe8(%rsp)
               	movl	%r13d, 0xf0(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xf8(%rsp)
               	movq	$0x0, 0x100(%rsp)
               	movl	%r13d, 0x108(%rsp)
               	movq	%r13, %xmm14
               	movsd	%xmm14, 0x110(%rsp)
               	movq	$0x0, 0x118(%rsp)
               	movl	$0x1, 0x120(%rsp)
               	jmp	<addr>
               	incq	%r13
               	cmpl	$0xa, %r13d
               	jae	<addr>
               	leaq	0x38(%rsp), %rax
               	imulq	$0x18, %r13, %rsi
               	addq	%rsi, %rax
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movsd	0x128(%rsp), %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movslq	0x8(%rax), %rdx
               	movl	0xc(%rax), %ecx
               	leaq	0x38(%rsp), %rax
               	addq	%rsi, %rax
               	movl	0x10(%rax), %eax
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	sete	%dil
               	movzbq	%dil, %rdi
               	testl	%edx, %edx
               	cmovneq	%rsi, %rdi
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdi, %rdi
               	cmovneq	%rax, %rsi
               	movl	$0x1, %r8d
               	testl	%ecx, %ecx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdx, %rdx
               	cmovneq	%r8, %rdi
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rsi, %rsi
               	cmoveq	%rax, %r8
               	movq	%rdi, %rax
               	shlq	%rax
               	orq	%rdx, %rax
               	movq	%rsi, %r9
               	shlq	$0x2, %r9
               	orq	%r9, %rax
               	movq	%r8, %r9
               	shlq	$0x3, %r9
               	orq	%r9, %rax
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	orq	%r9, %rax
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	orq	%rcx, %rax
               	shlq	$0x6, %rdx
               	orq	%rdx, %rax
               	shlq	$0x7, %rdi
               	orq	%rdi, %rax
               	shlq	$0x8, %rsi
               	orq	%rsi, %rax
               	shlq	$0x9, %r8
               	movq	%rax, %r14
               	orq	%r8, %r14
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	callq	<addr>
               	movq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	%rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	nop
               	callq	<addr>
               	shlq	$0x2, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x3, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x4, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x5, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x6, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x7, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x8, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	nop
               	callq	<addr>
               	shlq	$0x9, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	%rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x2, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x3, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x4, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x5, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x6, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x7, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	callq	<addr>
               	shlq	$0x8, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x9, %rax
               	orq	%r12, %rax
               	movq	$-0x1, %rcx
               	cmpl	%eax, %ebx
               	cmoveq	%rbx, %rcx
               	cmpl	%r14d, %ecx
               	jne	<addr>
               	leaq	0x38(%rsp), %rax
               	imulq	$0x18, %r13, %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movsd	0x28(%rsp), %xmm14
               	vcvtsd2ss	%xmm14, %xmm14, %xmm0
               	movsd	%xmm0, 0x28(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	%rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x2, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x3, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x4, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	nop
               	callq	<addr>
               	shlq	$0x5, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x6, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x7, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x8, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x9, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	%rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x2, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x3, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	callq	<addr>
               	shlq	$0x4, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x5, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x6, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x7, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x8, %rax
               	orq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	shlq	$0x9, %rax
               	orq	%r12, %rax
               	movq	$-0x1, %rcx
               	cmpl	%eax, %ebx
               	cmoveq	%rbx, %rcx
               	cmpl	%r14d, %ecx
               	je	<addr>
               	nopl	(%rax)
               	jmp	<addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	jmp	<addr>
               	leaq	0x14(%r13), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	leaq	0x1(%r13), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movsd	<rip>, %xmm0
               	movapd	%xmm0, %xmm1
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	movapd	%xmm0, %xmm1
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
