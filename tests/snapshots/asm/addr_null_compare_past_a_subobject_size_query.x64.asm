
addr_null_compare_past_a_subobject_size_query.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	xorl	%eax, %eax
               	movb	%al, 0x8(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	movl	$0x2, %ecx
               	movq	0x10(%rsp), %rdx
               	movabsq	$0xf0e0d0c0b0a0908, %r11 # imm = 0xF0E0D0C0B0A0908
               	cmpq	%r11, %rdx
               	cmovneq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq
