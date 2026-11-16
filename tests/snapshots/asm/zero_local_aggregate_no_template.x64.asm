
zero_local_aggregate_no_template.x64:	file format elf64-x86-64

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

<big_zero>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x200, %rsp            # imm = 0x200
               	leaq	-0x200(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movups	%xmm14, 0x40(%rcx)
               	movups	%xmm14, 0x50(%rcx)
               	movups	%xmm14, 0x60(%rcx)
               	movups	%xmm14, 0x70(%rcx)
               	movups	%xmm14, 0x80(%rcx)
               	movups	%xmm14, 0x90(%rcx)
               	movups	%xmm14, 0xa0(%rcx)
               	movups	%xmm14, 0xb0(%rcx)
               	movups	%xmm14, 0xc0(%rcx)
               	movups	%xmm14, 0xd0(%rcx)
               	movups	%xmm14, 0xe0(%rcx)
               	movups	%xmm14, 0xf0(%rcx)
               	movups	%xmm14, 0x100(%rcx)
               	movups	%xmm14, 0x110(%rcx)
               	movups	%xmm14, 0x120(%rcx)
               	movups	%xmm14, 0x130(%rcx)
               	movups	%xmm14, 0x140(%rcx)
               	movups	%xmm14, 0x150(%rcx)
               	movups	%xmm14, 0x160(%rcx)
               	movups	%xmm14, 0x170(%rcx)
               	movups	%xmm14, 0x180(%rcx)
               	movups	%xmm14, 0x190(%rcx)
               	movups	%xmm14, 0x1a0(%rcx)
               	movups	%xmm14, 0x1b0(%rcx)
               	movups	%xmm14, 0x1c0(%rcx)
               	movups	%xmm14, 0x1d0(%rcx)
               	movups	%xmm14, 0x1e0(%rcx)
               	movups	%xmm14, 0x1f0(%rcx)
               	xorl	%eax, %eax
               	cmpb	$0x0, -0x200(%rbp,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<seven>:
               	movl	$0x7, %eax
               	retq

<label_template>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0x10(%rbp,%rdi,8), %rax
               	jmpq	*%rax
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x14, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
