
inlined_struct_return_lifetime.x64:	file format elf64-x86-64

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

<returned_twice>:
               	xorl	%eax, %eax
               	movw	$0xa, <rip> # <addr>
               	retq

<one_of_two>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	movw	$0xa, <rip> # <addr>
               	testl	%esi, %esi
               	je	<addr>
               	movq	(%rsp), %rax
               	movq	$0x4, (%rax)
               	movq	$0x5, 0x8(%rax)
               	movq	$0x6, 0x10(%rax)
               	addq	$0x18, %rsp
               	retq
               	movq	(%rsp), %rax
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	addq	$0x18, %rsp
               	retq

<check_one>:
               	movw	$0xa, <rip> # <addr>
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	retq

<check_three>:
               	subq	$0x28, %rsp
               	leaq	<rip>, %rax # <addr>
               	movw	$0xa, <rip> # <addr>
               	movswq	<rip>, %r8 # <addr>
               	testl	%r8d, %r8d
               	jg	<addr>
               	movq	$0x1, 0x8(%rsp)
               	movq	$0x2, 0x10(%rsp)
               	movq	$0x3, 0x18(%rsp)
               	leaq	0x8(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movq	<rip>, %rax # <addr>
               	imulq	$0x64, %rax, %rax
               	movq	<rip>, %rcx # <addr>
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %r8 # <addr>
               	movq	%r8, (%rsp)
               	testl	%edi, %edi
               	je	<addr>
               	movq	$0x4, 0x8(%rsp)
               	movq	$0x5, 0x10(%rsp)
               	movq	$0x6, 0x18(%rsp)
               	jmp	<addr>
               	movq	$0x1, 0x8(%rsp)
               	movq	$0x2, 0x10(%rsp)
               	movq	$0x3, 0x18(%rsp)
               	jmp	<addr>

<main>:
               	pushq	%rax
               	movl	$0x9, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x1c8, %rax            # imm = 0x1C8
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
