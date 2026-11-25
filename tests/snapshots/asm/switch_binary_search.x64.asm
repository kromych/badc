
switch_binary_search.x64:	file format elf64-x86-64

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

<classify_signed>:
               	cmpl	$0x1, %edi
               	jl	<addr>
               	cmpl	$0x2a, %edi
               	jl	<addr>
               	cmpl	$0x3e8, %edi            # imm = 0x3E8
               	jl	<addr>
               	cmpl	$0x3e8, %edi            # imm = 0x3E8
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	cmpl	$0x2a, %edi
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpl	$0x7, %edi
               	jl	<addr>
               	cmpl	$0x7, %edi
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpl	$-0x3, %edi
               	jl	<addr>
               	testl	%edi, %edi
               	jl	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$-0x3, %edi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$-0x64, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<classify_unsigned>:
               	cmpl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	jb	<addr>
               	cmpl	$0x80000000, %edi       # imm = 0x80000000
               	jb	<addr>
               	cmpl	$-0x1, %edi
               	jb	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0x80000000, %edi       # imm = 0x80000000
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x5, %edi
               	jb	<addr>
               	cmpl	$0x5, %edi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	movq	$-0x64, %rdi
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	$-0x3, %rdi
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	xorl	%edi, %edi
               	callq	*%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x1, %edi
               	callq	*%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x7, %edi
               	callq	*%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2a, %edi
               	callq	*%rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	callq	*%rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	$-0x1, %rdi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x8, %edi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x3e7, %edi            # imm = 0x3E7
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	xorl	%edi, %edi
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x5, %edi
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	callq	*%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	*%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	callq	*%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x1, %edi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x80000001, %edi       # imm = 0x80000001
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x25, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
