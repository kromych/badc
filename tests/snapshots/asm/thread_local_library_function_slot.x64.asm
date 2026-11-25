
thread_local_library_function_slot.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	movq	<rip>, %rsi # <addr>
               	movq	%fs:0x0, %rdx
               	addq	$-0x8, %rdx
               	movq	(%rdx), %rcx
               	movq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	cmpq	%rsi, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdi, %rcx
               	cmovneq	%rax, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rdx), %rax
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpq	$0x2, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%r11
               	retq

<__c5_sys_strlen>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	movq	(%rsp), %rdi
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq
