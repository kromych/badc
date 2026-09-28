
inline_asm_x64_flags_push.x64:	file format elf64-x86-64

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
               	movl	$0x7, %r10d
               	movl	$0x7, %r11d
               	cmpq	%r11, %r10
               	pushfq
               	popq	%rax
               	testb	$0x40, %al
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x7, %r10d
               	movl	$0x9, %r11d
               	cmpq	%r11, %r10
               	pushfq
               	popq	%rax
               	testb	$0x40, %al
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x1234, %r10d          # imm = 0x1234
               	pushw	%r10w
               	popw	%ax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x1234, %rax           # imm = 0x1234
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0xbeef, %r10d          # imm = 0xBEEF
               	pushw	%r10w
               	popw	%ax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0xbeef, %rax           # imm = 0xBEEF
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x3, %r10d
               	movl	$0x3, %r11d
               	cmpq	%r11, %r10
               	pushfq
               	popq	%rax
               	pushq	%rax
               	popfq
               	pushfq
               	popq	%rax
               	testb	$0x40, %al
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
