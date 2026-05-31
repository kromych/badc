
bitop_common_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x14006f000, %r11      # imm = 0x14006F000
               	xorq	%r9, %r9
               	movq	%r11, %r8
               	orq	%r9, %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	movq	%rdi, %r8
               	cmpq	%r10, %rdi
               	je	0x400283 <.text+0x63>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %r8
               	xorq	$-0x1, %r8
               	movq	%r11, %rax
               	andq	%r8, %rax
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	movq	%r8, %rax
               	cmpq	%r10, %r8
               	je	0x4002c5 <.text+0xa5>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rax
               	xorq	%r9, %rax
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	movq	%r8, %rax
               	cmpq	%r10, %r8
               	je	0x4002fd <.text+0xdd>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x14006f001, %rax      # imm = 0x14006F001
               	movq	%rax, %r8
               	subq	$0x1, %r8
               	movl	$0xf, %eax
               	movslq	%eax, %rax
               	movq	%r8, %rsi
               	orq	%rax, %rsi
               	movq	%rsi, %rax
               	addq	$0x1, %rax
               	movabsq	$0x14006f010, %r10      # imm = 0x14006F010
               	movq	%rax, %rsi
               	cmpq	%r10, %rax
               	je	0x40034d <.text+0x12d>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rsi
               	orq	%r9, %rsi
               	movabsq	$0x14006f000, %r10      # imm = 0x14006F000
               	movq	%rsi, %rax
               	cmpq	%r10, %rsi
               	je	0x40037a <.text+0x15a>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rax
               	orq	%r9, %rax
               	movabsq	$0x14006f000, %r10      # imm = 0x14006F000
               	movq	%rax, %rsi
               	cmpq	%r10, %rax
               	je	0x4003a4 <.text+0x184>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rsi
               	orq	%r9, %rsi
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rsi, %r9
               	cmpq	%r11, %rsi
               	seta	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x0, %r9
               	jne	0x4003dd <.text+0x1bd>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
