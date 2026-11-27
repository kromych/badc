
function_typed_parameter.x64:	file format elf64-x86-64

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

<apply>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<apply_bare>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<passthrough>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<doubler>:
               	shlq	%rdi
               	movq	%rdi, %rax
               	retq

<take_slot>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax # <addr>
               	shlq	$0x2, %rdi
               	addq	%rdi, %rax
               	retq

<plain_func>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
