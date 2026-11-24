
sysv_abi_call_clobbers.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	vmulsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	%xmm1, 0x8(%rsp)
               	callq	<addr>
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	movsd	0x18(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	addsd	%xmm1, %xmm0
               	addq	$0x28, %rsp
               	retq

<keep_gpr>:
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
               	retq

<sv8>:
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm2, %xmm0 # xmm0 = (xmm2 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm3, %xmm0 # xmm0 = (xmm3 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm4, %xmm0 # xmm0 = (xmm4 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm5, %xmm0 # xmm0 = (xmm5 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm6, %xmm0 # xmm0 = (xmm6 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm7, %xmm0 # xmm0 = (xmm7 * mem) + xmm0
               	retq

<keep_across_sv8>:
               	subq	$0x28, %rsp
               	vmulsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movsd	<rip>, %xmm8
               	movsd	<rip>, %xmm9
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	movsd	<rip>, %xmm4
               	movsd	<rip>, %xmm5
               	movsd	<rip>, %xmm6
               	movsd	<rip>, %xmm7
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	%xmm1, 0x8(%rsp)
               	movapd	%xmm8, %xmm0
               	movapd	%xmm9, %xmm1
               	callq	<addr>
               	movapd	%xmm0, %xmm2
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	movsd	0x18(%rsp), %xmm14
               	vaddsd	%xmm2, %xmm14, %xmm2
               	vaddsd	%xmm0, %xmm2, %xmm0
               	addsd	%xmm1, %xmm0
               	addq	$0x28, %rsp
               	retq

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<keep_pointer>:
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
               	retq

<sv6>:
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm2, %xmm0 # xmm0 = (xmm2 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm3, %xmm0 # xmm0 = (xmm3 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm4, %xmm0 # xmm0 = (xmm4 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm5, %xmm0 # xmm0 = (xmm5 * mem) + xmm0
               	retq

<swap6>:
               	movapd	%xmm2, %xmm5
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	movsd	<rip>, %xmm4
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	jmp	<addr>

<main>:
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
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
               	movq	<rip>, %rbp # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x38(%rsp)
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	callq	<addr>
               	movl	$0x1, %ebx
               	xorl	%eax, %eax
               	ucomisd	<rip>, %xmm0
               	movq	%rax, %r10
               	cmovpq	%rbx, %r10
               	cmoveq	%r10, %rbx
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
               	movq	%rbx, %rax
               	orq	$0x4, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
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
               	movq	%rbx, %rax
               	orq	$0x10, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x88(%rsp), %xmm14
               	vfmadd132sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm0 * mem) + xmm14
               	movsd	0x78(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x70(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x68(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x60(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x58(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x50(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x48(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x40(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movq	%rbx, %rax
               	orq	$0x20, %rax
               	ucomisd	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	shlq	%r13
               	leaq	(%r12,%r13), %rax
               	leaq	(%r14,%r14,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r15
               	addq	%r15, %rax
               	leaq	(%rbp,%rbp,4), %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rbx, %rcx
               	orq	$0x40, %rcx
               	cmpq	$0x12d, %rax            # imm = 0x12D
               	cmoveq	%rbx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x68, %rsp
               	retq
