
ternary_arith_common_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %ecx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$-0x1, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
