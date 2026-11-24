
function_slots_name_weak_and_asm_functions.x64:	file format elf64-x86-64

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
               	movq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %edx
               	cmpl	$0x7, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%r11
               	retq
               	addb	%al, (%rax)

<asm_fn>:
               	movl	$0x7, %eax
               	retq
