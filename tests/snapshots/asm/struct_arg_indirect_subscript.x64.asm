
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
               	movl	$0x5, %eax
               	movq	%rax, 0x60(%rsp)
               	movq	$0x4, 0x68(%rsp)
               	movq	$0x6, 0x70(%rsp)
               	movq	%rax, 0x78(%rsp)
               	movq	$0x7, 0x80(%rsp)
               	movq	$0x6, 0x88(%rsp)
               	movq	$0x8, 0x90(%rsp)
               	movq	$0x7, 0x98(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	0x50(%rsp), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	movq	0x58(%rsp), %rsi
               	imulq	$0xa, %rsi, %rsi
               	addq	%rsi, %rdx
               	addq	$0x3, %rdx
               	movl	$0x1, %esi
               	xorl	%edi, %edi
               	testq	%rcx, %rcx
               	cmoveq	%rdi, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	cmpq	$0xfc2, %rcx            # imm = 0xFC2
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xa8, %rsp
               	retq
               	leaq	0x8(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	vmulsd	<rip>, %xmm2, %xmm0
               	vfmadd132sd	<rip>, %xmm0, %xmm1 # xmm1 = (xmm1 * mem) + xmm0
               	vaddsd	<rip>, %xmm1, %xmm1
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xa8, %rsp
               	retq
               	leaq	0x90(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsd	0x8(%rsp), %xmm0
               	movsd	0x10(%rsp), %xmm1
               	vmulsd	<rip>, %xmm1, %xmm1
               	vfmadd132sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	vaddsd	<rip>, %xmm0, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	addq	$0xa8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xa8, %rsp
               	retq
