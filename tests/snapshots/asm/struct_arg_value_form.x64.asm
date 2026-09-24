
struct_arg_value_form.x64:	file format elf64-x86-64

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

<take_kuid>:
               	movq	%rdi, %rax
               	retq

<take_pair>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	shlq	$0x20, %rax
               	movl	%edi, %ecx
               	orq	%rcx, %rax
               	retq

<take_kuid_proto>:
               	movq	%rdi, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
