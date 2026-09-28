
struct_arg_value_form_inline.x64:	file format elf64-x86-64

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

<take_triple>:
               	movq	%rdi, %rax
               	shrq	$0x8, %rax
               	movq	%rdi, %rcx
               	shrq	$0x10, %rcx
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	andq	$0xff, %rax
               	shlq	$0x8, %rax
               	orq	%rdx, %rax
               	andq	$0xff, %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	retq

<take_pair>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	shlq	$0x20, %rax
               	movl	%edi, %ecx
               	orq	%rcx, %rax
               	retq

<take_wide>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<main>:
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	retq
