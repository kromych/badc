
inline_section_mandatory.x64:	file format elf64-x86-64

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

<run_boot>:
               	movl	$0x5, %edi
               	jmp	<addr>

<run_text>:
               	pushq	%rax
               	movl	$0x4, %edi
               	callq	<addr>
               	addq	$0xd, %rax
               	popq	%r11
               	retq

<main>:
               	pushq	%rax
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x1c, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq

<boot_offset>:
               	movl	$0xb, %eax
               	retq

<boot_step>:
               	movl	$0x1c, %eax
               	retq
