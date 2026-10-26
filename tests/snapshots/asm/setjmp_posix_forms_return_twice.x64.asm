
setjmp_posix_forms_return_twice.x64:	file format elf64-x86-64

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

<jump_plain>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x3, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<jump_sig>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x5, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movl	$0x0, -0x108(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, -0x108(%rbp)
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0x108(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0xa, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, -0x108(%rbp)
               	xorl	%edi, %edi
               	leaq	-0x100(%rbp), %rsi
               	movq	%rdi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	callq	<addr>
               	ud2
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	-0x108(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	xorl	%esi, %esi
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
