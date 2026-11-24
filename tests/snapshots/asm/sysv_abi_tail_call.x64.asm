
sysv_abi_tail_call.x64:	file format elf64-x86-64

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
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm2, %xmm0 # xmm0 = (xmm2 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm3, %xmm0 # xmm0 = (xmm3 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm4, %xmm0 # xmm0 = (xmm4 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm5, %xmm0 # xmm0 = (xmm5 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm6, %xmm0 # xmm0 = (xmm6 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm7, %xmm0 # xmm0 = (xmm7 * mem) + xmm0
               	retq

<tail_int>:
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rcx
               	movq	%rsi, %rbx
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %rbp # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	callq	<addr>
               	movq	%rax, 0x58(%rsp)
               	movq	%rbx, %rcx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x58(%rsp), %rax
               	addq	%r10, %rax
               	leaq	(%r12,%r13), %rcx
               	addq	%r14, %rcx
               	leaq	(%rcx,%rax), %rdi
               	leaq	(%r15,%rbp), %rsi
               	movq	0x68(%rsp), %rdx
               	addq	0x60(%rsp), %rdx
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x28, %rsp
               	jmp	<addr>

<tail_fp>:
               	subq	$0x58, %rsp
               	subq	$0x20, %rsp
               	movsd	%xmm1, 0x68(%rsp)
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
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x28(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movsd	0x68(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movsd	0x60(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movsd	0x58(%rsp), %xmm1
               	movsd	0x50(%rsp), %xmm2
               	movsd	0x48(%rsp), %xmm3
               	movsd	0x40(%rsp), %xmm4
               	movsd	0x38(%rsp), %xmm5
               	movsd	0x30(%rsp), %xmm6
               	movsd	0x28(%rsp), %xmm7
               	addq	$0x20, %rsp
               	addq	$0x58, %rsp
               	jmp	<addr>

<main>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	movl	$0xa, %edi
               	movl	$0x14, %esi
               	callq	<addr>
               	movl	$0x1, %ebx
               	xorl	%ecx, %ecx
               	cmpq	$0xe77, %rax            # imm = 0xE77
               	cmoveq	%rcx, %rbx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	movq	%rbx, %rax
               	orq	$0x2, %rax
               	ucomisd	%xmm1, %xmm0
               	movq	%rbx, %r10
               	cmovpq	%rax, %r10
               	cmoveq	%r10, %rax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
