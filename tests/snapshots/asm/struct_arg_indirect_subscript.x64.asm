
struct_arg_indirect_subscript.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	$0x0, -0x88(%rbp)
               	movq	$0x1, -0x80(%rbp)
               	movq	$0x0, -0x78(%rbp)
               	movq	$0x2, -0x70(%rbp)
               	movq	$0x1, -0x68(%rbp)
               	movq	$0x3, -0x60(%rbp)
               	movq	$0x2, -0x58(%rbp)
               	movq	$0x4, -0x50(%rbp)
               	movq	$0x3, -0x48(%rbp)
               	movq	$0x5, -0x40(%rbp)
               	movq	$0x4, -0x38(%rbp)
               	movq	$0x6, -0x30(%rbp)
               	movq	$0x5, -0x28(%rbp)
               	movq	$0x7, -0x20(%rbp)
               	movq	$0x6, -0x18(%rbp)
               	movq	$0x8, -0x10(%rbp)
               	movq	$0x7, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movq	-0x50(%rbp), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	movq	-0x48(%rbp), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	addq	$0x3, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	leaq	(%rcx,%rdx), %rax
               	cmpq	$0xfc2, %rax            # imm = 0xFC2
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x98(%rbp), %xmm0
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movsd	-0x90(%rbp), %xmm1
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	mulsd	%xmm15, %xmm1
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movq	%rsi, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4027000000000000, %rdi # imm = 0x4027000000000000
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movsd	-0x98(%rbp), %xmm0
               	movsd	-0x90(%rbp), %xmm1
               	movq	%rdx, %xmm15
               	mulsd	%xmm15, %xmm1
               	movq	%rcx, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movq	%rsi, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
