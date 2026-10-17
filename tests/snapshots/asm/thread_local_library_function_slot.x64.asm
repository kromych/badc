
thread_local_library_function_slot.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rdx      # <addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rax
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rcx), %rsi
               	cmpq	%rdx, %rsi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rcx), %rax
               	callq	*%rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpq	$0x2, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>

<__c5_sys_strlen>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leave
               	retq
