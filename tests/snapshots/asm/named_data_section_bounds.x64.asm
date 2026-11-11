
named_data_section_bounds.x64:	file format elf64-x86-64

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
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	%rcx, %rdx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movl	0x8(%rax), %edi
               	movq	(%rax), %r8
               	movsbq	0x1(%r8), %r8
               	movl	$0x3e8, %r9d            # imm = 0x3E8
               	testl	%r8d, %r8d
               	movq	%r9, %r8
               	cmoveq	%rcx, %r8
               	addq	%r8, %rdi
               	addq	%rdi, %rsi
               	addq	$0x10, %rax
               	incq	%rdx
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rax
               	jb	<addr>
               	cmpl	$0x3, %edx
               	jne	<addr>
               	cmpl	$0x141, %esi            # imm = 0x141
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3e, %rsi
               	addq	%rsi, %rdx
               	sarq	$0x2, %rdx
               	cmpq	$0x2, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	cmpq	%rcx, %rdx
               	jb	<addr>
               	cmpq	%rax, %rdx
               	jae	<addr>
               	cmpq	%rcx, %rsi
               	jb	<addr>
               	cmpq	%rax, %rsi
               	jae	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x4, %edx
               	cmpl	$0x3, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq
