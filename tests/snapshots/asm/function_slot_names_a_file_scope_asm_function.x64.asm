
function_slot_names_a_file_scope_asm_function.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0x5, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%r11
               	retq
               	addb	%al, (%rax)

<fsa_fn>:
               	movl	$0x5, %eax
               	retq
