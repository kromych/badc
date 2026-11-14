
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
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x78(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x60(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x58(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x48(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x40(%rsp)
               	movq	%r10, %r11
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
               	shlq	%r12
               	leaq	(%rbx,%r12), %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r14
               	addq	%r14, %rax
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
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x58(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x38(%rsp)
               	callq	*%rdi
               	shlq	%r12
               	leaq	(%rbx,%r12), %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r14
               	addq	%r14, %rax
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
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x118(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x110(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x108(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x100(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0xf8(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0xf0(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
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
               	shlq	%r12
               	leaq	(%rbx,%r12), %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r14
               	addq	%r14, %rax
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
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x78(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x60(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x58(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x48(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x38(%rsp)
               	callq	*%rcx
               	movq	0x38(%rsp), %rcx
               	movq	%r12, %rdx
               	shlq	%rdx
               	addq	%rbx, %rdx
               	leaq	(%r13,%r13,2), %rsi
               	addq	%rsi, %rdx
               	movq	%r14, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	leaq	(%r15,%r15,4), %rsi
               	addq	%rsi, %rdx
               	movq	0x78(%rsp), %rsi
               	imulq	$0x6, %rsi, %rsi
               	addq	%rsi, %rdx
               	movq	0x70(%rsp), %rsi
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	movq	0x68(%rsp), %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdi # imm = 0x4010000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rdi, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	movq	%rsi, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4018000000000000, %rsi # imm = 0x4018000000000000
               	movq	%rsi, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4020000000000000, %rsi # imm = 0x4020000000000000
               	movq	%rsi, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	cvttsd2si	%xmm0, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rax,%rdx), %r10
               	movq	%r10, 0x40(%rsp)
               	callq	*%rcx
               	movq	%rax, %r10
               	movq	0x40(%rsp), %rax
               	addq	%r10, %rax
               	shlq	%r12
               	leaq	(%rbx,%r12), %rcx
               	leaq	(%r13,%r13,2), %rdx
               	addq	%rdx, %rcx
               	shlq	$0x2, %r14
               	addq	%r14, %rcx
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
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x58(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x38(%rsp)
               	callq	*%rdi
               	shlq	%r12
               	leaq	(%rbx,%r12), %rcx
               	leaq	(%r13,%r13,2), %rdx
               	addq	%rdx, %rcx
               	shlq	$0x2, %r14
               	addq	%r14, %rcx
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
               	subq	$0x78, %rsp
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %r9 # <addr>
               	movq	<rip>, %rbx # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm2 # <addr>
               	movsd	<rip>, %xmm3 # <addr>
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%rdx,%rdx,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	leaq	(%rdi,%rdi,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r8, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %r9, %rcx
               	addq	%rcx, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
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
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
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
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x3fe8000000000000, %rcx # imm = 0x3FE8000000000000
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x58(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x50(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x48(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x40(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x38(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x20(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x18(%rsp)
               	movq	%rcx, %xmm0
               	movq	%rdx, %xmm1
               	callq	*%rax
               	movq	0x68(%rsp), %rax
               	shlq	%rax
               	movq	%rax, %r10
               	movq	0x70(%rsp), %rax
               	addq	%r10, %rax
               	movq	0x60(%rsp), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movsd	0x28(%rsp), %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x30(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x20(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x18(%rsp), %xmm14, %xmm1 # xmm1 = (xmm14 * mem) + xmm1
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
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movsd	0x78(%rsp), %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	leaq	0x3e8(%rbx), %rcx
               	shlq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x78(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x58(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x50(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x48(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x40(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x20(%rsp)
               	callq	*%rax
               	movq	0x70(%rsp), %rcx
               	shlq	%rcx
               	movq	%rcx, %r10
               	movq	0x78(%rsp), %rcx
               	addq	%r10, %rcx
               	movq	0x68(%rsp), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	movq	0x60(%rsp), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movq	0x58(%rsp), %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x50(%rsp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x48(%rsp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x40(%rsp), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movsd	0x30(%rsp), %xmm14
               	movq	%rsi, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x38(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x28(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4020000000000000, %rdx # imm = 0x4020000000000000
               	movq	%rdx, %xmm14
               	vfmadd231sd	0x20(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	0x3e8(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

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
