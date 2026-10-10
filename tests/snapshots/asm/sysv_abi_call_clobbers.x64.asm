
sysv_abi_call_clobbers.x64:	file format elf64-x86-64

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

<clobber>:
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
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

<keep_fp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	%xmm1, (%rsp)
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm14
               	vfmadd132sd	(%rsp), %xmm14, %xmm0 # xmm0 = (xmm0 * mem) + xmm14
               	movsd	(%rsp), %xmm15
               	addsd	%xmm15, %xmm0
               	leave
               	retq

<keep_gpr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	movq	%r13, %rcx
               	imulq	%r14, %rcx
               	leaq	(%rax,%rcx), %r15
               	callq	<addr>
               	leaq	(%r15,%rbx), %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<sv8>:
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm15) + xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm15) + xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm4, %xmm0 # xmm0 = (xmm4 * xmm15) + xmm0
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm5, %xmm0 # xmm0 = (xmm5 * xmm15) + xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm6, %xmm0 # xmm0 = (xmm6 * xmm15) + xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm7, %xmm0 # xmm0 = (xmm7 * xmm15) + xmm0
               	retq

<keep_across_sv8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	%xmm1, 0x10(%rsp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movabsq	$0x4014000000000000, %rdi # imm = 0x4014000000000000
               	movabsq	$0x4018000000000000, %r8 # imm = 0x4018000000000000
               	movabsq	$0x401c000000000000, %r9 # imm = 0x401C000000000000
               	movabsq	$0x4020000000000000, %rbx # imm = 0x4020000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rdx, %xmm2
               	movq	%rsi, %xmm3
               	movq	%rdi, %xmm4
               	movq	%r8, %xmm5
               	movq	%r9, %xmm6
               	movq	%rbx, %xmm7
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vfmadd231sd	0x10(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x18(%rsp), %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	0x10(%rsp), %xmm15
               	addsd	%xmm15, %xmm0
               	popq	%rbx
               	leave
               	retq

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<keep_pointer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movq	%r12, %rdi
               	callq	*%rbx
               	movq	%rax, %r15
               	movq	%r13, %rdi
               	callq	*%rbx
               	addq	%r15, %rax
               	movq	%r12, %rcx
               	imulq	%r13, %rcx
               	addq	%rcx, %rax
               	addq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<sv6>:
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm15) + xmm0
               	movabsq	$0x408f400000000000, %rax # imm = 0x408F400000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm15) + xmm0
               	movabsq	$0x40c3880000000000, %rax # imm = 0x40C3880000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm4, %xmm0 # xmm0 = (xmm4 * xmm15) + xmm0
               	movabsq	$0x40f86a0000000000, %rax # imm = 0x40F86A0000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm5, %xmm0 # xmm0 = (xmm5 * xmm15) + xmm0
               	retq

<swap6>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movapd	%xmm2, %xmm5
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	movq	%rax, %xmm2
               	movq	%rcx, %xmm3
               	movq	%rdx, %xmm4
               	popq	%rbp
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x88(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0x80(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0x78(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0x70(%rsp)
               	movsd	0x20(%rax), %xmm14
               	movsd	%xmm14, 0x68(%rsp)
               	movsd	0x28(%rax), %xmm14
               	movsd	%xmm14, 0x60(%rsp)
               	movsd	0x30(%rax), %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	movsd	0x38(%rax), %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	0x40(%rax), %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x48(%rax), %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r12
               	movq	0x8(%rax), %r13
               	movq	0x10(%rax), %r14
               	movq	0x18(%rax), %r15
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm0
               	movsd	0x8(%rax), %xmm1
               	callq	<addr>
               	movabsq	$0x4026000000000000, %rax # imm = 0x4026000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	movq	0x10(%rax), %rdx
               	movq	0x18(%rax), %rcx
               	callq	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	orq	$0x2, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm0
               	movsd	0x8(%rax), %xmm1
               	callq	<addr>
               	movabsq	$0x406ae00000000000, %rax # imm = 0x406AE00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x4, %rbx
               	leaq	-<rip>, %rdi      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	0x8(%rax), %rsi
               	movq	0x10(%rax), %rdx
               	movq	0x20(%rax), %rcx
               	callq	<addr>
               	cmpq	$0x23, %rax
               	je	<addr>
               	orq	$0x8, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm0
               	movsd	0x8(%rax), %xmm1
               	movsd	0x10(%rax), %xmm2
               	callq	<addr>
               	movabsq	$0x4123f7e600000000, %rax # imm = 0x4123F7E600000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x10, %rbx
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm0
               	movsd	0x88(%rsp), %xmm14
               	vfmadd132sd	0x80(%rsp), %xmm14, %xmm0 # xmm0 = (xmm0 * mem) + xmm14
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x78(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x70(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x68(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x58(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x40(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4078100000000000, %rax # imm = 0x4078100000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x20, %rbx
               	movq	%r13, %rax
               	shlq	%rax
               	addq	%r12, %rax
               	leaq	(%r14,%r14,2), %rcx
               	addq	%rcx, %rax
               	movq	%r15, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x12d, %rax            # imm = 0x12D
               	je	<addr>
               	orq	$0x40, %rbx
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%ebx, %ebx
               	jmp	<addr>
