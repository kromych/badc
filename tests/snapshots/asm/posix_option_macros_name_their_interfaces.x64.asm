
posix_option_macros_name_their_interfaces.x64:	file format elf64-x86-64

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

<pthread_atfork>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<main>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	$0x0, (%rcx,%rax,8)
               	je	<addr>
               	incq	%rax
               	cmpq	$0x0, (%rcx,%rax,8)
               	jne	<addr>
               	testl	%eax, %eax
               	jle	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x63, %eax
               	jmp	<addr>
