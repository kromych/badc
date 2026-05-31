
string_literal_no_room_for_nul.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movzbq	(%r11), %r9
               	xorq	$0x65, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400265 <.text+0x45>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfe64(%rip), %r9       # 0x4100d0
               	addq	$0xf, %r9
               	movzbq	(%r9), %rax
               	xorq	$0x6b, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40029e <.text+0x7e>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfe4b(%rip), %rax      # 0x4100f0
               	movzbq	(%rax), %r9
               	xorq	$0x68, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4002cc <.text+0xac>
               	movl	$0x3, %eax
               	retq
               	leaq	0xfe1d(%rip), %r9       # 0x4100f0
               	addq	$0x4, %r9
               	movzbq	(%r9), %rax
               	xorq	$0x6f, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400305 <.text+0xe5>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfde4(%rip), %rax      # 0x4100f0
               	addq	$0x5, %rax
               	movzbq	(%rax), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400333 <.text+0x113>
               	movl	$0x5, %eax
               	retq
               	leaq	0xfdb6(%rip), %r9       # 0x4100f0
               	addq	$0x13, %r9
               	movzbq	(%r9), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400365 <.text+0x145>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfda8(%rip), %rax      # 0x410114
               	movzbq	(%rax), %r9
               	xorq	$0x77, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400393 <.text+0x173>
               	movl	$0x7, %eax
               	retq
               	leaq	0xfd7a(%rip), %r9       # 0x410114
               	addq	$0x4, %r9
               	movzbq	(%r9), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4003cc <.text+0x1ac>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfd41(%rip), %rax      # 0x410114
               	addq	$0x5, %rax
               	movzbq	(%rax), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4003fa <.text+0x1da>
               	movl	$0x9, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	addb	%al, (%rax)
