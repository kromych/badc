
pragma_pack_push_pop_forms.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movq	$0x1d, 0x8(%rax)
               	movq	0x8(%rax), %rcx
               	cmpq	$0x38, %rcx
               	jae	<addr>
               	movq	0x8(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x8(%rax), %rcx
               	cmpq	$0x38, %rcx
               	jb	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	andq	$0x1fffff, %rcx         # imm = 0x1FFFFF
               	shlq	$0x2b, %rcx
               	sarq	$0x2b, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpw	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x18, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rsi
               	movb	$0x38, 0x8(%rsi)
               	leaq	<rip>, %rdi
               	movl	$0x18, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
