
function_slots_name_weak_and_asm_functions.x64:	file format elf64-x86-64

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
               	movq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, %edx
               	cmpl	$0x7, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbp
               	retq
               	addb	%bh, 0x7(%rax)

<asm_fn>:
               	movl	$0x7, %eax
               	retq
