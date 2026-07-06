
switch_unsigned_negative_case.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<u32>:
               	movl	%edi, %eax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jb	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq
               	movl	$0x64, %eax
               	retq
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0xc8, %eax
               	retq
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<u16>:
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq
               	movl	$0x64, %eax
               	retq
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<u8>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq
               	movl	$0x64, %eax
               	retq
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<s32>:
               	movslq	%edi, %rdi
               	cmpq	$-0x1, %rdi
               	jl	<addr>
               	cmpq	$-0x1, %rdi
               	je	<addr>
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq
               	movl	$0x64, %eax
               	retq
               	cmpq	$-0x2, %rdi
               	jne	<addr>
               	movl	$0xc8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xfffffffe, %edi       # imm = 0xFFFFFFFE
               	callq	<addr>
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rdi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
