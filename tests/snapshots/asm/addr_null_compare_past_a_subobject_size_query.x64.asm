
addr_null_compare_past_a_subobject_size_query.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rcx
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jb	<addr>
               	movq	-0x10(%rbp), %rax
               	movabsq	$0xf0e0d0c0b0a0908, %r11 # imm = 0xF0E0D0C0B0A0908
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
