
struct_arg_indirect_subscript.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0xa8, %rsp
               	movq	$0x0, 0x18(%rsp)
               	movq	$0x1, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	movq	$0x2, 0x30(%rsp)
               	movq	$0x1, 0x38(%rsp)
               	movq	$0x3, 0x40(%rsp)
               	movq	$0x2, 0x48(%rsp)
               	movq	$0x4, 0x50(%rsp)
               	movq	$0x3, 0x58(%rsp)
               	movq	$0x5, 0x60(%rsp)
               	movq	$0x4, 0x68(%rsp)
               	movq	$0x6, 0x70(%rsp)
               	movq	$0x5, 0x78(%rsp)
               	movq	$0x7, 0x80(%rsp)
               	movq	$0x6, 0x88(%rsp)
               	movq	$0x8, 0x90(%rsp)
               	movq	$0x7, 0x98(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	0x50(%rsp), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	movq	0x58(%rsp), %rdx
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
               	addq	$0xa8, %rsp
               	retq
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	vmulsd	<rip>, %xmm2, %xmm0
               	vfmadd132sd	<rip>, %xmm0, %xmm1 # xmm1 = (xmm1 * mem) + xmm0
               	vaddsd	<rip>, %xmm1, %xmm1
               	movsd	<rip>, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xa8, %rsp
               	retq
               	leaq	0x90(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x8(%rsp), %xmm1
               	movsd	0x10(%rsp), %xmm2
               	vmulsd	<rip>, %xmm2, %xmm2
               	vfmadd132sd	<rip>, %xmm2, %xmm1 # xmm1 = (xmm1 * mem) + xmm2
               	vaddsd	<rip>, %xmm1, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xa8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xa8, %rsp
               	retq
