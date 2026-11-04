
sys_addr_in_static_init.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	movq	%rsi, %rdx
               	callq	*%rax
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x4, %edx
               	movq	%rbx, %rdi
               	callq	*%rax
               	movq	%rax, %r12
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rdi
               	callq	*%rax
               	cmpl	$0x4, %r12d
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
