
call_conv_derived_calls_keep_values.x64:	file format elf64-x86-64

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

<through_types>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movsd	%xmm0, 0x88(%rsp)
               	movsd	%xmm1, 0x80(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r15
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x60(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r11
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x80(%rsp), %xmm1
               	callq	*%r11
               	movq	%r12, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	cvttsd2si	%xmm1, %rcx
               	addq	%rcx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vaddsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movq	0x40(%rsp), %r11
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x80(%rsp), %xmm1
               	callq	*%r11
               	movq	%r12, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	cvttsd2si	%xmm1, %rcx
               	addq	%rcx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x38(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x80(%rsp), %xmm1
               	callq	<addr>
               	movq	%r12, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	cvttsd2si	%xmm1, %rcx
               	addq	%rcx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x38(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x80(%rsp), %xmm1
               	callq	<addr>
               	movq	%r12, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	cvttsd2si	%xmm1, %rcx
               	addq	%rcx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x38(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movq	0x40(%rsp), %r11
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x80(%rsp), %xmm1
               	callq	*%r11
               	movsd	0x38(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movq	%r12, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	cvttsd2si	%xmm1, %rcx
               	addq	%rcx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<old_style>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r15
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	callq	*%rdi
               	movq	%r12, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0x48(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x40(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x38(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	cvttsd2si	%xmm1, %rcx
               	addq	%rcx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<through_va_arg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x118, %rsp            # imm = 0x118
               	movq	%rdi, -0x110(%rbp)
               	movq	%rsi, -0x108(%rbp)
               	movq	%rdx, -0x100(%rbp)
               	movq	%rcx, -0xf8(%rbp)
               	movq	%r8, -0xf0(%rbp)
               	movq	%r9, -0xe8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xe0(%rbp)
               	movups	%xmm1, -0xd0(%rbp)
               	movups	%xmm2, -0xc0(%rbp)
               	movups	%xmm3, -0xb0(%rbp)
               	movups	%xmm4, -0xa0(%rbp)
               	movups	%xmm5, -0x90(%rbp)
               	movups	%xmm6, -0x80(%rbp)
               	movups	%xmm7, -0x70(%rbp)
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r15
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x118(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x110(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x108(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x100(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0xf8(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0xf0(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0xe8(%rsp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x110(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0x110(%rbp), %r10
               	movq	%r10, 0x10(%rax)
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
               	movq	(%rax), %rax
               	movabsq	$0x3fe8000000000000, %rcx # imm = 0x3FE8000000000000
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm0
               	movq	%rdx, %xmm1
               	callq	*%rax
               	leaq	-0x18(%rbp), %rax
               	movq	%r12, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x118(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x110(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x108(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0xf8(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x100(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0xf0(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0xe8(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	cvttsd2si	%xmm1, %rcx
               	addq	%rcx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<int_through_types>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r15
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x60(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r11
               	callq	*%r11
               	movq	%r12, %rcx
               	shlq	%rcx
               	addq	%rbx, %rcx
               	leaq	(%r13,%r13,2), %rdx
               	addq	%rdx, %rcx
               	movq	%r14, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	(%r15,%r15,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x78(%rsp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x70(%rsp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rsi, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4020000000000000, %rdx # imm = 0x4020000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r11
               	callq	*%r11
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	addq	%r10, %rax
               	movq	%r12, %rcx
               	shlq	%rcx
               	addq	%rbx, %rcx
               	leaq	(%r13,%r13,2), %rdx
               	addq	%rdx, %rcx
               	movq	%r14, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	(%r15,%r15,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x78(%rsp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x70(%rsp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rsi, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4020000000000000, %rdx # imm = 0x4020000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<int_old_style>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r15
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	callq	*%rdi
               	movq	%r12, %rcx
               	shlq	%rcx
               	addq	%rbx, %rcx
               	leaq	(%r13,%r13,2), %rdx
               	addq	%rdx, %rcx
               	movq	%r14, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	(%r15,%r15,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x60(%rsp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x58(%rsp), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movsd	0x48(%rsp), %xmm14
               	movq	%rsi, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x40(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4020000000000000, %rdx # imm = 0x4020000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x38(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %r9
               	movq	0x30(%rax), %rbx
               	movq	0x38(%rax), %r12
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm0
               	movsd	0x8(%rax), %xmm1
               	movsd	0x10(%rax), %xmm2
               	movsd	0x18(%rax), %xmm3
               	movq	%rdx, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	leaq	(%rsi,%rsi,2), %rcx
               	addq	%rcx, %rax
               	movq	%rdi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %rbx, %rcx
               	addq	%rcx, %rax
               	movq	%r12, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rdx, %xmm15
               	mulsd	%xmm15, %xmm1
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm15
               	vfmadd231sd	%xmm15, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm15) + xmm0
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm15
               	vfmadd231sd	%xmm15, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	<rip>, %rax      # <addr>
               	leaq	<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	leaq	<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	movabsq	$0x3fd8000000000000, %rax # imm = 0x3FD8000000000000
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	movq	%rax, %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm14
               	movsd	%xmm14, 0x78(%rsp)
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm14
               	vmulsd	0x78(%rsp), %xmm14, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movabsq	$0x3fe8000000000000, %rdx # imm = 0x3FE8000000000000
               	movabsq	$0x3fe0000000000000, %rsi # imm = 0x3FE0000000000000
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r12
               	movq	0x8(%rax), %r13
               	movq	0x10(%rax), %r14
               	movq	0x18(%rax), %r15
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movq	%rdx, %xmm0
               	movq	%rsi, %xmm1
               	callq	*%rcx
               	movq	%r13, %rax
               	shlq	%rax
               	addq	%r12, %rax
               	leaq	(%r14,%r14,2), %rcx
               	addq	%rcx, %rax
               	movq	%r15, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0x48(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x40(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x38(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	cvttsd2si	%xmm1, %rcx
               	addq	%rcx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x78(%rsp), %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movsd	0x78(%rsp), %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	callq	<addr>
               	leaq	0x3e8(%rbx), %rcx
               	shlq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r12
               	movq	0x8(%rax), %r13
               	movq	0x10(%rax), %r14
               	movq	0x18(%rax), %r15
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	callq	*%rcx
               	movq	%r13, %rcx
               	shlq	%rcx
               	addq	%r12, %rcx
               	leaq	(%r14,%r14,2), %rdx
               	addq	%rdx, %rcx
               	movq	%r15, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movq	0x78(%rsp), %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x70(%rsp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x60(%rsp), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movsd	0x50(%rsp), %xmm14
               	movq	%rsi, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x58(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4020000000000000, %rdx # imm = 0x4020000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x40(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	0x3e8(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	addb	%al, (%rax)

<svd>:
               	mulsd	%xmm1, %xmm0
               	movabsq	$0x7777777777777777, %rcx # imm = 0x7777777777777777
               	movq	%rcx, %rdx
               	movq	%rcx, %rsi
               	movq	%rcx, %rdi
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rcx, %r10
               	movq	%rcx, %r11
               	pcmpeqd	%xmm1, %xmm1
               	pcmpeqd	%xmm2, %xmm2
               	pcmpeqd	%xmm3, %xmm3
               	pcmpeqd	%xmm4, %xmm4
               	pcmpeqd	%xmm5, %xmm5
               	pcmpeqd	%xmm6, %xmm6
               	pcmpeqd	%xmm7, %xmm7
               	pcmpeqd	%xmm8, %xmm8
               	pcmpeqd	%xmm9, %xmm9
               	pcmpeqd	%xmm10, %xmm10
               	pcmpeqd	%xmm11, %xmm11
               	pcmpeqd	%xmm12, %xmm12
               	pcmpeqd	%xmm13, %xmm13
               	pcmpeqd	%xmm14, %xmm14
               	pcmpeqd	%xmm15, %xmm15
               	retq

<svi>:
               	movabsq	$0x7777777777777777, %rcx # imm = 0x7777777777777777
               	movq	%rcx, %rdx
               	movq	%rcx, %rsi
               	movq	%rcx, %rdi
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rcx, %r10
               	movq	%rcx, %r11
               	pcmpeqd	%xmm1, %xmm1
               	pcmpeqd	%xmm2, %xmm2
               	pcmpeqd	%xmm3, %xmm3
               	pcmpeqd	%xmm4, %xmm4
               	pcmpeqd	%xmm5, %xmm5
               	pcmpeqd	%xmm6, %xmm6
               	pcmpeqd	%xmm7, %xmm7
               	pcmpeqd	%xmm8, %xmm8
               	pcmpeqd	%xmm9, %xmm9
               	pcmpeqd	%xmm10, %xmm10
               	pcmpeqd	%xmm11, %xmm11
               	pcmpeqd	%xmm12, %xmm12
               	pcmpeqd	%xmm13, %xmm13
               	pcmpeqd	%xmm14, %xmm14
               	pcmpeqd	%xmm15, %xmm15
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	retq
