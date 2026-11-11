
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
               	subq	$0x20, %rsp
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	%xmm1, 0x10(%rsp)
               	movsd	0x18(%rsp), %xmm14
               	vmulsd	0x10(%rsp), %xmm14, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm14
               	vaddsd	0x18(%rsp), %xmm14, %xmm0
               	vaddsd	0x10(%rsp), %xmm0, %xmm0
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
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	0x28(%rsp), %xmm14
               	vmulsd	0x20(%rsp), %xmm14, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
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
               	vaddsd	%xmm0, %xmm14, %xmm0
               	vaddsd	0x28(%rsp), %xmm0, %xmm0
               	vaddsd	0x20(%rsp), %xmm0, %xmm0
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
               	imulq	%r13, %r12
               	addq	%r12, %rax
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
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x88(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x80(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x78(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x70(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x68(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x60(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x58(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x50(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x40(%rsp)
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x38(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x30(%rsp)
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	callq	<addr>
               	movabsq	$0x4026000000000000, %rax # imm = 0x4026000000000000
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rdx, %rbx
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	callq	<addr>
               	movq	%rbx, %rcx
               	orq	$0x2, %rcx
               	cmpq	$0x28, %rax
               	cmovneq	%rcx, %rbx
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	callq	<addr>
               	movabsq	$0x406ae00000000000, %rax # imm = 0x406AE00000000000
               	movq	%rbx, %rcx
               	orq	$0x4, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rcx, %rbx
               	cmovpq	%rcx, %rbx
               	leaq	-<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rcx # <addr>
               	callq	<addr>
               	movq	%rbx, %rcx
               	orq	$0x8, %rcx
               	cmpq	$0x23, %rax
               	cmovneq	%rcx, %rbx
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm2 # <addr>
               	callq	<addr>
               	movabsq	$0x4123f7e600000000, %rax # imm = 0x4123F7E600000000
               	movq	%rbx, %rcx
               	orq	$0x10, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	movq	%rbx, %rax
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movsd	0x80(%rsp), %xmm0
               	movq	%rcx, %xmm14
               	vfmadd213sd	0x88(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * xmm0) + mem
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x78(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x70(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x68(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x60(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x401c000000000000, %rcx # imm = 0x401C000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x58(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x50(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4022000000000000, %rcx # imm = 0x4022000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x48(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	0x40(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movabsq	$0x4078100000000000, %rcx # imm = 0x4078100000000000
               	movq	%rax, %rdx
               	orq	$0x20, %rdx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rdx, %rax
               	cmovpq	%rdx, %rax
               	shlq	%r13
               	leaq	(%r12,%r13), %rcx
               	leaq	(%r14,%r14,2), %rdx
               	addq	%rdx, %rcx
               	shlq	$0x2, %r15
               	addq	%r15, %rcx
               	movq	0x38(%rsp), %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x30(%rsp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	cmpq	$0x12d, %rcx            # imm = 0x12D
               	cmovneq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
