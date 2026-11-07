
zero_sign_extension_32bit.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x80000001, %ebx       # imm = 0x80000001
               	je	<addr>
               	movl	$0x28, <rip> # <addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0x5d, %edx
               	movl	$0x28, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x80000001, %ebx       # imm = 0x80000001
               	je	<addr>
               	movl	$0x29, <rip> # <addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0x5e, %edx
               	movl	$0x29, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	jmp	<addr>
