
switch_binary_search.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify_signed>:
               	movslq	%edi, %rdi
               	cmpq	$0x1, %rdi
               	jl	<addr>
               	cmpq	$0x2a, %rdi
               	jl	<addr>
               	cmpq	$0x3e8, %rdi            # imm = 0x3E8
               	jl	<addr>
               	cmpq	$0x3e8, %rdi            # imm = 0x3E8
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x7, %eax
               	retq
               	cmpq	$0x2a, %rdi
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpq	$0x7, %rdi
               	jl	<addr>
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpq	$-0x3, %rdi
               	jl	<addr>
               	testq	%rdi, %rdi
               	jl	<addr>
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$-0x3, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$-0x64, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<classify_unsigned>:
               	movl	%edi, %eax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	jb	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
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
               	xorq	%rax, %rax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$0x5, %rax
               	jb	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movabsq	$-0x64, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbp
               	retq
               	movl	$0x8, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbp
               	retq
               	movl	$0x3e7, %edi            # imm = 0x3E7
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbp
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbp
               	retq
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	popq	%rbp
               	retq
               	movl	$0x80000001, %edi       # imm = 0x80000001
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
