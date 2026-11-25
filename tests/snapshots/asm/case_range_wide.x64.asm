
case_range_wide.x64:	file format elf64-x86-64

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

<classify_u>:
               	cmpl	$0x100000, %edi         # imm = 0x100000
               	jae	<addr>
               	cmpl	$0x7, %edi
               	jae	<addr>
               	cmpl	$0xf0000000, %edi       # imm = 0xF0000000
               	jae	<addr>
               	cmpl	$0x5, %edi
               	jb	<addr>
               	cmpl	$0x5, %edi
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x64, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x9, %edi
               	jbe	<addr>
               	jmp	<addr>
               	cmpl	$0x1fffff, %edi         # imm = 0x1FFFFF
               	ja	<addr>
               	movl	$0x1, %eax
               	retq

<classify_s>:
               	cmpl	$-0x64, %edi
               	jge	<addr>
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	cmpl	$-0x32, %edi
               	jg	<addr>
               	movl	$0xa, %eax
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	xorl	%edi, %edi
               	callq	*%rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x100000, %edi         # imm = 0x100000
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x1fffff, %edi         # imm = 0x1FFFFF
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x16e360, %edi         # imm = 0x16E360
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xfffff, %edi          # imm = 0xFFFFF
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x200000, %edi         # imm = 0x200000
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x5, %edi
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x7, %edi
               	callq	*%rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x9, %edi
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x6, %edi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xf0000000, %edi       # imm = 0xF0000000
               	callq	*%rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	callq	*%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0xefffffff, %edi       # imm = 0xEFFFFFFF
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	$-0x64, %rdi
               	callq	*%rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$-0x32, %rdi
               	callq	*%rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$-0x4b, %rdi
               	callq	*%rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	$-0x65, %rdi
               	callq	*%rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$-0x31, %rdi
               	callq	*%rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	xorl	%edi, %edi
               	callq	*%rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
