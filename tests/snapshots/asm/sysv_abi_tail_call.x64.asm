
sysv_abi_tail_call.x64:	file format elf64-x86-64

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

<ms_id>:
               	movq	%rcx, %rax
               	retq

<ms_idd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm14, (%rsp)
               	movups	%xmm15, 0x10(%rsp)
               	movups	(%rsp), %xmm14
               	movups	0x10(%rsp), %xmm15
               	leave
               	retq

<sv_sum>:
               	imulq	$0x64, %rdi, %rax
               	imulq	$0xa, %rsi, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
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

<tail_int>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rcx
               	movq	%rsi, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r14
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r15
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, 0x30(%rsp)
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	0x30(%rsp), %rax
               	addq	%r10, %rax
               	leaq	(%r12,%r13), %rcx
               	addq	%r14, %rcx
               	leaq	(%rcx,%rax), %rdi
               	movq	%r15, %rsi
               	addq	0x48(%rsp), %rsi
               	movq	0x40(%rsp), %rdx
               	addq	0x38(%rsp), %rdx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	jmp	<addr>

<tail_fp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movsd	%xmm1, 0x48(%rsp)
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	0x8(%rax), %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	0x10(%rax), %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x18(%rax), %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	0x20(%rax), %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movsd	0x28(%rax), %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movsd	0x30(%rax), %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movsd	0x38(%rax), %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	movsd	%xmm0, (%rsp)
               	subq	$0x20, %rsp
               	movsd	0x68(%rsp), %xmm0
               	callq	<addr>
               	addq	$0x20, %rsp
               	movsd	(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movsd	0x40(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movsd	0x30(%rsp), %xmm2
               	movsd	0x28(%rsp), %xmm3
               	movsd	0x20(%rsp), %xmm4
               	movsd	0x18(%rsp), %xmm5
               	movsd	0x10(%rsp), %xmm6
               	movsd	0x8(%rsp), %xmm7
               	leave
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0xa, %edi
               	movl	$0x14, %esi
               	callq	<addr>
               	cmpq	$0xe77, %rax            # imm = 0xE77
               	je	<addr>
               	movl	$0x1, %ebx
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x3fd0000000000000, %rcx # imm = 0x3FD0000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	movabsq	$0x4069980000000000, %rax # imm = 0x4069980000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x2, %rbx
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ebx, %ebx
               	jmp	<addr>
